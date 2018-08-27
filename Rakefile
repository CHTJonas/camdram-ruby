lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Unit test tasks
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = Dir.glob("test/*_tests.rb").sort
  t.verbose = false
  t.warning = false
end

# RubyGems tasks
require 'camdram/version'
task :build do
  system "gem build camdram-ruby"
end
task :release => :build do
  system "gem push camdram-ruby-#{Camdram::Version}.gem"
end
