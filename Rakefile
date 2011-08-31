require 'bundler'
Bundler.setup
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rake/testtask'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "--format progress"
end

RSpec::Core::RakeTask.new(:spec)

Rake::TestTask.new(:units) do |t|
  t.test_files = Dir["test/**/test_*.rb"]
  t.verbose = true
end

task :default => [:spec, :units, :cucumber]
