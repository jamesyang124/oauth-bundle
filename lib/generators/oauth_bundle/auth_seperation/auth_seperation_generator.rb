module OauthBundle
  module Generators
    class AuthSeperationGenerator < ::Rails::Generators::Base
      def preset
        puts "Expect to seperate authentication data from user model."
      end
    end
  end
end