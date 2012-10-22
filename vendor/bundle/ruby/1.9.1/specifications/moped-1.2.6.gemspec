# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "moped"
  s.version = "1.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bernerd Schaefer"]
  s.date = "2012-10-04"
  s.description = "A MongoDB driver for Ruby."
  s.email = ["bj.schaefer@gmail.com"]
  s.homepage = "http://mongoid.org/moped"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A MongoDB driver for Ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
