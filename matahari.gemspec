# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'matahari/version'

Gem::Specification.new do |s|
  s.name = %q{matahari}
  s.version = Matahari::VERSION

  s.authors = ["Tom Stuart"]
  s.email = ["tom@therye.org"]
  s.files = Dir.glob("lib/**/*") + ["README.rdoc"]
  s.homepage = %q{https://github.com/mortice/matahari}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.summary = %q{Test spy library, inspired by Mockito and RR}
	s.description = "Matahari provides test spies for Ruby"

	s.add_development_dependency "rspec"
	s.add_development_dependency "cucumber"
	s.add_development_dependency "aruba"
  s.add_development_dependency "rake"

	s.require_path = "lib"
	s.required_rubygems_version = ">= 1.3.6"
end
