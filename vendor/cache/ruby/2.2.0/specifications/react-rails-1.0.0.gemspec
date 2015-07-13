# -*- encoding: utf-8 -*-
# stub: react-rails 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "react-rails"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Paul O\u{2019}Shannessy"]
  s.date = "2015-04-07"
  s.description = "Compile your JSX on demand or precompile for production."
  s.email = ["paul@oshannessy.com"]
  s.homepage = "https://github.com/reactjs/react-rails"
  s.licenses = ["APL 2.0"]
  s.rubygems_version = "2.4.5"
  s.summary = "React/JSX adapter for the Ruby on Rails asset pipeline."

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<appraisal>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 1.2.2"])
      s.add_development_dependency(%q<coffee-rails>, [">= 0"])
      s.add_development_dependency(%q<es5-shim-rails>, [">= 2.0.5"])
      s.add_development_dependency(%q<jbuilder>, [">= 0"])
      s.add_development_dependency(%q<poltergeist>, [">= 0.3.3"])
      s.add_development_dependency(%q<test-unit>, ["~> 2.5"])
      s.add_development_dependency(%q<turbolinks>, [">= 2.0.0"])
      s.add_runtime_dependency(%q<coffee-script-source>, ["~> 1.8"])
      s.add_runtime_dependency(%q<connection_pool>, [">= 0"])
      s.add_runtime_dependency(%q<execjs>, [">= 0"])
      s.add_runtime_dependency(%q<rails>, [">= 3.1"])
      s.add_runtime_dependency(%q<react-source>, ["~> 0.13"])
    else
      s.add_dependency(%q<appraisal>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 1.2.2"])
      s.add_dependency(%q<coffee-rails>, [">= 0"])
      s.add_dependency(%q<es5-shim-rails>, [">= 2.0.5"])
      s.add_dependency(%q<jbuilder>, [">= 0"])
      s.add_dependency(%q<poltergeist>, [">= 0.3.3"])
      s.add_dependency(%q<test-unit>, ["~> 2.5"])
      s.add_dependency(%q<turbolinks>, [">= 2.0.0"])
      s.add_dependency(%q<coffee-script-source>, ["~> 1.8"])
      s.add_dependency(%q<connection_pool>, [">= 0"])
      s.add_dependency(%q<execjs>, [">= 0"])
      s.add_dependency(%q<rails>, [">= 3.1"])
      s.add_dependency(%q<react-source>, ["~> 0.13"])
    end
  else
    s.add_dependency(%q<appraisal>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 1.2.2"])
    s.add_dependency(%q<coffee-rails>, [">= 0"])
    s.add_dependency(%q<es5-shim-rails>, [">= 2.0.5"])
    s.add_dependency(%q<jbuilder>, [">= 0"])
    s.add_dependency(%q<poltergeist>, [">= 0.3.3"])
    s.add_dependency(%q<test-unit>, ["~> 2.5"])
    s.add_dependency(%q<turbolinks>, [">= 2.0.0"])
    s.add_dependency(%q<coffee-script-source>, ["~> 1.8"])
    s.add_dependency(%q<connection_pool>, [">= 0"])
    s.add_dependency(%q<execjs>, [">= 0"])
    s.add_dependency(%q<rails>, [">= 3.1"])
    s.add_dependency(%q<react-source>, ["~> 0.13"])
  end
end
