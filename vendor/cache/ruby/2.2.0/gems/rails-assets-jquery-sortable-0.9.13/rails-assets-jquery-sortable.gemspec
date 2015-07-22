# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-jquery-sortable/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-jquery-sortable"
  spec.version       = RailsAssetsJquerySortable::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = ""
  spec.summary       = ""
  spec.homepage      = "http://johnny.github.io/jquery-sortable"
  spec.license       = "BSD-3"

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
