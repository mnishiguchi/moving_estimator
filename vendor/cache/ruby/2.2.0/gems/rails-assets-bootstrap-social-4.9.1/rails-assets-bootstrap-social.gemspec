# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-bootstrap-social/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-bootstrap-social"
  spec.version       = RailsAssetsBootstrapSocial::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = ""
  spec.summary       = ""
  spec.homepage      = "https://github.com/lipis/bootstrap-social"
  spec.license       = "MIT"

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency "rails-assets-bootstrap", "~> 3"
  spec.add_dependency "rails-assets-font-awesome", "~> 4.3"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
