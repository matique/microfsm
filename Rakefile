require "rake"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs.push "test"
  t.pattern = "test/*_test.rb"
end

desc "Default: run unit tests."
task default: :test
