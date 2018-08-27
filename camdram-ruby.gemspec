lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'camdram/version'

Gem::Specification.new do |s|
  s.name          = 'camdram'
  s.version       = Camdram::VERSION
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

  s.add_dependency 'json', '~> 2.1'
  s.add_dependency 'minitest', '~> 5.11'
  s.add_development_dependency 'bundler', '~> 1.5'
  s.add_development_dependency 'rake', '~> 12.3'
end
