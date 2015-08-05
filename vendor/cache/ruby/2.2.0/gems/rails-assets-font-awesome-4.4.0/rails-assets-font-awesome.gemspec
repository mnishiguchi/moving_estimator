# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-font-awesome/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-font-awesome"
  spec.version       = RailsAssetsFontAwesome::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = "Font Awesome"
  spec.summary       = "Font Awesome"
  spec.homepage      = "http://fontawesome.io/"
  spec.licenses      = ["OFL-1.1", "MIT", "CC-BY-3.0"]

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
