# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "origin"
  s.version = "1.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Durran Jordan"]
  s.date = "2012-09-22"
  s.description = "Origin is a simple DSL for generating MongoDB selectors and options"
  s.email = ["durran@gmail.com"]
  s.homepage = "http://mongoid.org"
  s.require_paths = ["lib"]
  s.rubyforge_project = "origin"
  s.rubygems_version = "1.8.24"
  s.summary = "Simple DSL for MongoDB query generation"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<activesupport>, ["~> 3.1"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 0.6"])
      s.add_development_dependency(%q<i18n>, ["~> 0.6"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8"])
      s.add_development_dependency(%q<tzinfo>, ["~> 0.3.22"])
    else
      s.add_dependency(%q<activesupport>, ["~> 3.1"])
      s.add_dependency(%q<guard-rspec>, ["~> 0.6"])
      s.add_dependency(%q<i18n>, ["~> 0.6"])
      s.add_dependency(%q<rspec>, ["~> 2.8"])
      s.add_dependency(%q<tzinfo>, ["~> 0.3.22"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 3.1"])
    s.add_dependency(%q<guard-rspec>, ["~> 0.6"])
    s.add_dependency(%q<i18n>, ["~> 0.6"])
    s.add_dependency(%q<rspec>, ["~> 2.8"])
    s.add_dependency(%q<tzinfo>, ["~> 0.3.22"])
  end
end
