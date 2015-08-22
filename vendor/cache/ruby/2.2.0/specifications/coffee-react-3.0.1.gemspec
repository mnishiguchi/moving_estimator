# -*- encoding: utf-8 -*-
# stub: coffee-react 3.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "coffee-react"
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["James Friend"]
  s.date = "2015-03-24"
  s.description = "    ruby-coffee-react is a bridge to the npm coffee-react-transform module, which \n    transforms CJSX (Coffeescript with React JSX-style markup) into valid Coffeescript.\n    If you want to use CJSX with Rails/Sprockets, see the sprockets-coffee-react gem.\n"
  s.email = "james@jsdf.co"
  s.homepage = "http://github.com/jsdf/ruby-coffee-react"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "coffee-react-transform for ruby"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<execjs>, [">= 0"])
      s.add_development_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<execjs>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<execjs>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
