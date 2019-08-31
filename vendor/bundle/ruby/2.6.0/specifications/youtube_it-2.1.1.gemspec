# -*- encoding: utf-8 -*-
# stub: youtube_it 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "youtube_it".freeze
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["kylejginavan".freeze, "chebyte".freeze, "mseppae".freeze]
  s.date = "2011-12-19"
  s.description = "Upload, delete, update, comment on youtube videos all from one gem.".freeze
  s.email = "kylejginavan@gmail.com".freeze
  s.extra_rdoc_files = ["README.rdoc".freeze]
  s.files = ["README.rdoc".freeze]
  s.homepage = "http://github.com/kylejginavan/youtube_it".freeze
  s.rubygems_version = "3.0.6".freeze
  s.summary = "The most complete Ruby wrapper for youtube api's".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<oauth>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<simple_oauth>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<builder>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<faraday>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<oauth>.freeze, [">= 0.4.4"])
      s.add_runtime_dependency(%q<simple_oauth>.freeze, [">= 0.1.5"])
      s.add_runtime_dependency(%q<faraday>.freeze, [">= 0.7.3"])
      s.add_runtime_dependency(%q<builder>.freeze, [">= 0"])
    else
      s.add_dependency(%q<oauth>.freeze, [">= 0"])
      s.add_dependency(%q<simple_oauth>.freeze, [">= 0"])
      s.add_dependency(%q<builder>.freeze, [">= 0"])
      s.add_dependency(%q<faraday>.freeze, [">= 0"])
      s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
      s.add_dependency(%q<oauth>.freeze, [">= 0.4.4"])
      s.add_dependency(%q<simple_oauth>.freeze, [">= 0.1.5"])
      s.add_dependency(%q<faraday>.freeze, [">= 0.7.3"])
      s.add_dependency(%q<builder>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<oauth>.freeze, [">= 0"])
    s.add_dependency(%q<simple_oauth>.freeze, [">= 0"])
    s.add_dependency(%q<builder>.freeze, [">= 0"])
    s.add_dependency(%q<faraday>.freeze, [">= 0"])
    s.add_dependency(%q<nokogiri>.freeze, [">= 0"])
    s.add_dependency(%q<oauth>.freeze, [">= 0.4.4"])
    s.add_dependency(%q<simple_oauth>.freeze, [">= 0.1.5"])
    s.add_dependency(%q<faraday>.freeze, [">= 0.7.3"])
    s.add_dependency(%q<builder>.freeze, [">= 0"])
  end
end
