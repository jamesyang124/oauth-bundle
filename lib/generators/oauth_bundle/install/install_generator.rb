module OauthBundle
  module Generators
    class InstallGenerator < Rails::Generators::Base

      # public method will be run automatically.
      
      def config_devise_and_model
        model = ask "Please provide model name:"
        model = model.tableize
        system "rails g devise:install"
        system "rails g devise #{model}"

        # add_omniauth_to_routes_file
        gsub_file "config/routes.rb", /devise_for :#{model}/, "devise_for :#{model}, :controller => {:omniauth_callbacks => 'users/omniauth_callbacks'}"
      end

      def add_omniauth_to_devise_file
        here = [:github, :facebook, :twitter].map do |e|
          "  config.omniauth :#{e}, 'APP_ID', 'APP_SECRET'"
        end.join("\n")

        inject_into_file "config/initializers/devise.rb", here + "\n", after: "# config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'\n"
      end 

      def add_devise_omniauth_to_user_model
      
      end

    end
  end
end