require "bundler/gem_tasks"
require "rake/testtask"
require "yard"

task :default => :test

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList["test/*_test.rb"]
  t.verbose = false
end

YARD::Rake::YardocTask.new do |t|
  # t.files   = ['lib/**/*.rb', OTHER_PATHS]
  # t.options = ['--any', '--extra', '--opts']
end
