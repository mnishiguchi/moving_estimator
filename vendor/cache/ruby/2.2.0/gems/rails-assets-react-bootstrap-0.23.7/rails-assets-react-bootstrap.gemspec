# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-react-bootstrap/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-react-bootstrap"
  spec.version       = RailsAssetsReactBootstrap::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = ""
  spec.summary       = ""
  spec.homepage      = "http://react-bootstrap.github.io/"
  spec.license       = "MIT"

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency "rails-assets-classnames", ">= 2.0.0", "< 3"
  spec.add_dependency "rails-assets-react", ">= 0.13"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
