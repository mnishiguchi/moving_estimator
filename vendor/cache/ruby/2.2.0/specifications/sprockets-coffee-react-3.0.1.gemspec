# -*- encoding: utf-8 -*-
# stub: sprockets-coffee-react 3.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "sprockets-coffee-react"
  s.version = "3.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["James Friend"]
  s.date = "2015-03-24"
  s.description = "    Preprocessor for Coffeescript with React JSX (CJSX). \n    This gem makes it easy to integrate this into the Rails asset pipeline or other Sprockets chains.\n    If you want to use CJSX without Sprockets, see the coffee-react gem, or the coffee-react npm module.\n"
  s.email = "james@jsdf.co"
  s.homepage = "https://github.com/jsdf/sprockets-coffee-react"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Coffeescript with React JSX (CJSX) via Sprockets"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<coffee-react>, [">= 3.0.1"])
      s.add_runtime_dependency(%q<coffee-script>, [">= 0"])
      s.add_runtime_dependency(%q<tilt>, [">= 0"])
      s.add_runtime_dependency(%q<sprockets>, [">= 0"])
    else
      s.add_dependency(%q<coffee-react>, [">= 3.0.1"])
      s.add_dependency(%q<coffee-script>, [">= 0"])
      s.add_dependency(%q<tilt>, [">= 0"])
      s.add_dependency(%q<sprockets>, [">= 0"])
    end
  else
    s.add_dependency(%q<coffee-react>, [">= 3.0.1"])
    s.add_dependency(%q<coffee-script>, [">= 0"])
    s.add_dependency(%q<tilt>, [">= 0"])
    s.add_dependency(%q<sprockets>, [">= 0"])
  end
end
