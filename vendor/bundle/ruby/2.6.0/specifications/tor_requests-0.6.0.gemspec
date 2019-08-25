# -*- encoding: utf-8 -*-
# stub: tor_requests 0.6.0 ruby lib

Gem::Specification.new do |s|
  s.name = "tor_requests".freeze
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Bruno Ghisi".freeze]
  s.date = "2014-04-07"
  s.description = "Create anonymously requests through Tor network".freeze
  s.email = "brunogh@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.homepage = "http://github.com/brunogh/tor_requests".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Create anonymously requests through Tor network".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.11.0"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3.5"])
      s.add_development_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_development_dependency(%q<socksify>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<socksify>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["~> 2.11.0"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3.5"])
      s.add_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>.freeze, [">= 0"])
      s.add_dependency(%q<socksify>.freeze, [">= 0"])
      s.add_dependency(%q<socksify>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["~> 2.11.0"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.12"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3.5"])
    s.add_dependency(%q<jeweler>.freeze, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<socksify>.freeze, [">= 0"])
    s.add_dependency(%q<socksify>.freeze, [">= 0"])
  end
end
