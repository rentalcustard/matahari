# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{matahari}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tom Stuart"]
  s.date = %q{2011-01-13}
  s.email = %q{tom@therye.org}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "test/spy_test.rb", "spec/debriefing_spec.rb", "spec/spec_helper.rb", "spec/spy_spec.rb", "lib/matahari/debriefing.rb", "lib/matahari/rspec/matchers.rb", "lib/matahari/spy.rb", "lib/matahari.rb"]
  s.homepage = %q{https://github.com/mortice/matahari}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Test spy library, inspired by Mockito and RR}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
  end
end
