require 'bundler'
Bundler.setup
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "--format progress"
end

RSpec::Core::RakeTask.new(:spec)

task :default => [:spec, :cucumber]
