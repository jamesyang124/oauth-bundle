module OauthBundle
  module Generators
    class InstallGenerator < Rails::Generators::Base

      # public method will be run automatically.
      
      def install_devise_auth_model
        model = ask "Please provide authentication model name (default: users):"
        model = (model.empty? ? "users" : model).tableize
        @auth_model = model

        install_devise model
        config_devise_routes model
      end

      def create_migration_for_auth_model
        system "rails g migration AddColumnsTo#{@auth_model.capitalize} provider uid"
        system "rake db:migrate" 
      end

      def add_omniauth_to_devise_file
        @providers = [:github, :facebook, :twitter]
        inject_str = @providers.map do |e|
          "  config.omniauth :#{e}, 'APP_ID', 'APP_SECRET'"
        end.join("\n") + "\n"

        inject_into_file "config/initializers/devise.rb", inject_str, 
        :after => "scope: 'user,public_repo'\n"
      end 

      def add_devise_omniauth_to_user_model
        inject_str = "  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :github]\n"
        inject_into_file "app/models/user.rb", inject_str, :after => ":validatable\n"
      end

      def generate_omniauth_callback_controllers
        path = "app/controllers/#{@auth_model}/omniauth_callbacks_controller.rb"
        create_file path
        append_file path, omniauth_callback_contrllers_content
      end

      private

      def install_devise(model)
        system "rails g devise:install"
        unless File.exist?("app/models/#{model.singularize}.rb")
          system "rails g devise #{model.singularize}"
        end
      end

      def config_devise_routes(model)
        gsub_file "config/routes.rb", /devise_for :#{model}$/, "devise_for :#{model}, :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}"
      end

      def omniauth_callback_contrllers_content
        content = "class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController\n"
        providers = @providers.map do |e|
          "  def #{e}\n    #handle callback data in here.\n  end\n"
        end.join("\n")

        "#{content}#{providers}end\n"
      end
    end
  end
end