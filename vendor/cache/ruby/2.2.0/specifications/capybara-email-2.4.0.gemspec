# -*- encoding: utf-8 -*-
# stub: capybara-email 2.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "capybara-email"
  s.version = "2.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Brian Cardarella"]
  s.date = "2014-07-07"
  s.description = "Test your ActionMailer and Mailer messages in Capybara"
  s.email = ["bcardarella@gmail.com", "brian@dockyard.com"]
  s.homepage = "https://github.com/dockyard/capybara-email"
  s.rubygems_version = "2.4.5"
  s.summary = "Test your ActionMailer and Mailer messages in Capybara"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mail>, [">= 0"])
      s.add_runtime_dependency(%q<capybara>, ["~> 2.4"])
      s.add_development_dependency(%q<actionmailer>, ["> 3.0"])
      s.add_development_dependency(%q<bourne>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<mail>, [">= 0"])
      s.add_dependency(%q<capybara>, ["~> 2.4"])
      s.add_dependency(%q<actionmailer>, ["> 3.0"])
      s.add_dependency(%q<bourne>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<mail>, [">= 0"])
    s.add_dependency(%q<capybara>, ["~> 2.4"])
    s.add_dependency(%q<actionmailer>, ["> 3.0"])
    s.add_dependency(%q<bourne>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
