# -*- encoding: utf-8 -*-
# stub: sidekiq-unique-jobs 6.0.13 ruby lib

Gem::Specification.new do |s|
  s.name = "sidekiq-unique-jobs".freeze
  s.version = "6.0.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/mhenrixon/sidekiq-unique-jobs/issues", "changelog_uri" => "https://github.com/mhenrixon/sidekiq-unique-jobs/CHANGELOG.md", "documentation_uri" => "https://mhenrixon.github.io/sidekiq-unique-jobs", "homepage_uri" => "https://mhenrixon.github.io/sidekiq-unique-jobs", "source_code_uri" => "https://github.com/mhenrixon/sidekiq-unique-jobs" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mikael Henriksson".freeze]
  s.date = "2019-04-14"
  s.description = "Prevents simultaneous Sidekiq jobs with the same unique arguments to run.\nHighly configurable to suite your specific needs.\n".freeze
  s.email = ["mikael@zoolutions.se".freeze]
  s.executables = ["uniquejobs".freeze]
  s.files = ["bin/uniquejobs".freeze]
  s.homepage = "https://mhenrixon.github.io/sidekiq-unique-jobs".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.6".freeze
  s.summary = "Sidekiq middleware that prevents duplicates jobs".freeze

  s.installed_by_version = "3.0.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0", ">= 1.0.5"])
      s.add_runtime_dependency(%q<sidekiq>.freeze, [">= 4.0", "< 7.0"])
      s.add_runtime_dependency(%q<thor>.freeze, ["~> 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 2.0"])
      s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.3"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_development_dependency(%q<sinatra>.freeze, [">= 0"])
      s.add_development_dependency(%q<timecop>.freeze, ["~> 0.9"])
      s.add_development_dependency(%q<github-markup>.freeze, ["~> 3.0"])
      s.add_development_dependency(%q<github_changelog_generator>.freeze, ["~> 1.14"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.9.18"])
      s.add_development_dependency(%q<gem-release>.freeze, [">= 2.0"])
    else
      s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0", ">= 1.0.5"])
      s.add_dependency(%q<sidekiq>.freeze, [">= 4.0", "< 7.0"])
      s.add_dependency(%q<thor>.freeze, ["~> 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 2.0"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_dependency(%q<sinatra>.freeze, [">= 0"])
      s.add_dependency(%q<timecop>.freeze, ["~> 0.9"])
      s.add_dependency(%q<github-markup>.freeze, ["~> 3.0"])
      s.add_dependency(%q<github_changelog_generator>.freeze, ["~> 1.14"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.9.18"])
      s.add_dependency(%q<gem-release>.freeze, [">= 2.0"])
    end
  else
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0", ">= 1.0.5"])
    s.add_dependency(%q<sidekiq>.freeze, [">= 4.0", "< 7.0"])
    s.add_dependency(%q<thor>.freeze, ["~> 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 2.0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.9"])
    s.add_dependency(%q<github-markup>.freeze, ["~> 3.0"])
    s.add_dependency(%q<github_changelog_generator>.freeze, ["~> 1.14"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9.18"])
    s.add_dependency(%q<gem-release>.freeze, [">= 2.0"])
  end
end
