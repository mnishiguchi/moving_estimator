# -*- encoding: utf-8 -*-
# stub: json_spec 1.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "json_spec"
  s.version = "1.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Steve Richert"]
  s.date = "2014-10-10"
  s.description = "RSpec matchers and Cucumber steps for testing JSON content"
  s.email = ["steve.richert@gmail.com"]
  s.homepage = "https://github.com/collectiveidea/json_spec"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Easily handle JSON in RSpec and Cucumber"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_runtime_dependency(%q<rspec>, ["< 4.0", ">= 2.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
    else
      s.add_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, ["< 4.0", ">= 2.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<multi_json>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, ["< 4.0", ">= 2.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
  end
end
