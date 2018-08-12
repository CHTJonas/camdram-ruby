lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'camdram/version'

Gem::Specification.new do |spec|
  spec.name          = "camdram"
  spec.version       = Camdram::VERSION
  spec.authors       = ["Charlie Jonas"]
  spec.email         = ["devel@charliejonas.co.uk"]
  spec.description   = "Camdram API wrapper"
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "net"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
