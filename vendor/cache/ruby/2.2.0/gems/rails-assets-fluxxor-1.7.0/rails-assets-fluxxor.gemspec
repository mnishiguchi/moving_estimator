# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-fluxxor/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-fluxxor"
  spec.version       = RailsAssetsFluxxor::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = "Flux architecture tools for React"
  spec.summary       = "Flux architecture tools for React"
  spec.homepage      = "https://github.com/BinaryMuse/fluxxor"
  spec.license       = "MIT"

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
