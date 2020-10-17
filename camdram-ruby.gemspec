lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'camdram/version'

Gem::Specification.new do |s|
  s.name          = 'camdram'
  s.version       = Camdram::Version.to_s
  s.license       = 'MIT'
  s.summary       = 'A lovely API wrapper for Camdram written in Ruby'
  s.description   = 'This gem acts as a convenient wrapper around the public API provided by a Camdram installation. See GitHub for a brief overview of available functionality and RubyDocs for more complete documentation.'
  s.authors       = ['Charlie Jonas']
  s.email         = ['devel@charliejonas.co.uk']
  s.homepage      = 'https://github.com/CHTJonas/camdram-ruby'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'oauth2', '~> 1.4'
  s.add_dependency 'mime-types', '~> 3.2'
  s.add_dependency 'sync', '~> 0.5.0'
  s.add_dependency 'ruby_multiton', '~> 0.1.2'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'minitest', '~> 5.11'
  s.add_development_dependency 'minitest-retry', '~> 0.2.1'
end
