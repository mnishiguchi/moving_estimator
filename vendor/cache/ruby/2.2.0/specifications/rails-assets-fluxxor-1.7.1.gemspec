# -*- encoding: utf-8 -*-
# stub: rails-assets-fluxxor 1.7.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-assets-fluxxor"
  s.version = "1.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["rails-assets.org"]
  s.date = "2015-08-06"
  s.description = "Flux architecture tools for React"
  s.homepage = "https://github.com/BinaryMuse/fluxxor"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Flux architecture tools for React"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
