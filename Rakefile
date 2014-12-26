# encoding: utf-8
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

task :default => :test
