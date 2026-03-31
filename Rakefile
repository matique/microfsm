require "rake"
require "rake/testtask"

desc "Run the tests."
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/*_test.rb"
end

desc "Default: run unit tests."
task default: :test
