# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "aaronh-chronic"
  s.version = "0.3.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Preston-Werner"]
  s.autorequire = "chronic"
  s.date = "2010-09-10"
  s.email = "tom@rubyisawesome.com"
  s.extra_rdoc_files = ["README.txt"]
  s.files = ["README.txt"]
  s.homepage = "http://chronic.rubyforge.org"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A natural language date parser with timezone support"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
