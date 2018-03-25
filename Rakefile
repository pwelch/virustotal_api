
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs       = ['lib']
  t.warning    = true
  t.verbose    = true
  t.test_files = FileList['test/*_test.rb']
end

RuboCop::RakeTask.new

require 'yard'
YARD::Rake::YardocTask.new
namespace :yard do
  desc 'Run the YARD server'
  task :start do
    sh 'bundle exec yard server --reload'
  end
end

task :default => :test
