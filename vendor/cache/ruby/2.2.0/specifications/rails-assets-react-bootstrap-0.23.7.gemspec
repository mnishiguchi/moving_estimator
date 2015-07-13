# -*- encoding: utf-8 -*-
# stub: rails-assets-react-bootstrap 0.23.7 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-assets-react-bootstrap"
  s.version = "0.23.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["rails-assets.org"]
  s.date = "2015-07-01"
  s.description = ""
  s.homepage = "http://react-bootstrap.github.io/"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = ""

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails-assets-classnames>, ["< 3", ">= 2.0.0"])
      s.add_runtime_dependency(%q<rails-assets-react>, [">= 0.13"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rails-assets-classnames>, ["< 3", ">= 2.0.0"])
      s.add_dependency(%q<rails-assets-react>, [">= 0.13"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails-assets-classnames>, ["< 3", ">= 2.0.0"])
    s.add_dependency(%q<rails-assets-react>, [">= 0.13"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
