# -*- encoding: utf-8 -*-
# stub: terminator 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "terminator".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ara T. Howard".freeze]
  s.date = "2013-08-17"
  s.description = "an external timeout mechanism based on processes and signals".freeze
  s.email = "ara.t.howard@gmail.com".freeze
  s.homepage = "https://github.com/ahoward/terminator".freeze
  s.licenses = ["same as ruby's".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "terminator".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fattr>.freeze, [">= 2.2"])
    else
      s.add_dependency(%q<fattr>.freeze, [">= 2.2"])
    end
  else
    s.add_dependency(%q<fattr>.freeze, [">= 2.2"])
  end
end
