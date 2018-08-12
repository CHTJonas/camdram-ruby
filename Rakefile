lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Unit test tasks
require 'rake/testtask'
Rake::TestTask.new("test") { |t|
  raise "API test key is not set!" if !ENV["API_test_key"]
  t.libs << 'test'
  t.test_files = Dir.glob("test/*_tests.rb").sort
  t.verbose = false
  t.warning = false
}

# RubyGems tasks
require 'camdram/version'
task :build do
  system "gem build .gemspec"
end
task :release => :build do
  system "gem push bundler-#{Camdram::Version}"
end
