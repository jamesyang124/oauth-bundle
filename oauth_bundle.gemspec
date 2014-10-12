# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oauth_bundle/version'

Gem::Specification.new do |spec|
  spec.name          = "oauth_bundle"
  spec.version       = OauthBundle::VERSION
  spec.authors       = ["James Yang"]
  spec.email         = ["jamesyang124@gmail.com"]
  spec.summary       = %q{Bundle omniauth-facebook, omniauth-github, omniauth-twitter with Devise gem.}
  spec.description   = %q{`Create new rails app, then run rails g oauth_bundle:install`}
  spec.homepage      = "https://github.com/jamesyang124/oauth_bundle"
  spec.license       = "MIT"

  spec.add_dependency "devise"
  spec.add_dependency "omniauth"
  spec.add_dependency "omniauth-facebook"
  spec.add_dependency "omniauth-twitter"
  spec.add_dependency "omniauth-github"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
