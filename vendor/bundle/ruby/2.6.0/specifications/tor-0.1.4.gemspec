# -*- encoding: utf-8 -*-
# stub: tor 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "tor".freeze
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Arto Bendiken".freeze]
  s.date = "2019-06-07"
  s.description = "Tor.rb is a Ruby library for interacting with the Tor anonymity network.".freeze
  s.email = "or-talk@seul.org".freeze
  s.homepage = "http://cypherpunk.rubyforge.org/tor/".freeze
  s.licenses = ["Public Domain".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.1".freeze)
  s.requirements = ["Tor (>= 0.2.1.25)".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Onion routing for Ruby.".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<yard>.freeze, [">= 0.6.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 3"])
    else
      s.add_dependency(%q<yard>.freeze, [">= 0.6.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 3"])
    end
  else
    s.add_dependency(%q<yard>.freeze, [">= 0.6.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 3"])
  end
end
