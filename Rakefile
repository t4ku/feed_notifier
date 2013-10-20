require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.pattern = "spec/*_spec.rb"
end

# there's no public methods for setting description to TestTask...
task(:spec).instance_variable_set :@comments,['run specs']

task :default => [:spec]
