Gem::Specification.new do |s|
  s.name = %q{iorb}
  s.version = "0.5.90"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sergio RubioSergio Rubio"]
  s.date = %q{2009-05-04}
  s.default_executable = %q{iorb}
  s.description = %q{drop.io CLI interface}
  s.email = %q{sergio@rubio.namesergio@rubio.name}
  s.executables = ["iorb"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "THANKS.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "THANKS.txt", "bin/iorb", "dropio-ruby-api-examples/add_files.rb", "dropio-ruby-api-examples/basic_client.rb", "dropio-ruby-api-examples/destroy_drop.rb", "dropio-ruby-api-examples/find_drop.rb", "dropio-ruby-api-examples/find_my_drop.rb", "dropio-ruby-api-examples/list_files.rb", "iorb.gemspec", "lib/iorb.rb", "lib/iorb/commands/add.rb", "lib/iorb/commands/create.rb", "lib/iorb/commands/destroy.rb", "lib/iorb/commands/info.rb", "lib/iorb/commands/list.rb", "lib/iorb/commands/mail.rb", "lib/iorb/commands/mydrops.rb", "lib/iorb/commands/send_to_drop.rb", "lib/iorb/commands/update.rb", "scripts/newrelease"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rubiojr/iorb}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{iorb}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{drop.io CLI interface}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dropio>, [">= 0.9"])
      s.add_runtime_dependency(%q<visionmedia-commander>, [">= 3.2"])
      s.add_development_dependency(%q<hoe>, [">= 1.12.1"])
    else
      s.add_dependency(%q<dropio>, [">= 0.9"])
      s.add_dependency(%q<visionmedia-commander>, [">= 3.2"])
      s.add_dependency(%q<hoe>, [">= 1.12.1"])
    end
  else
    s.add_dependency(%q<dropio>, [">= 0.9"])
    s.add_dependency(%q<visionmedia-commander>, [">= 3.2"])
    s.add_dependency(%q<hoe>, [">= 1.12.1"])
  end
end
