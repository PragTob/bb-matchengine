# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bb_matchengine/version'

Gem::Specification.new do |spec|
  spec.name          = "bb_matchengine"
  spec.version       = BBMatchengine::VERSION
  spec.authors       = ["Tobias Pfeiffer", "Jalyna Schroeder"]
  spec.email         = ["pragtob@gmail.com", "jalyna.schroeder@gmail.com"]
  spec.summary       = %q{Do not use. Prototype of a basketball match engine.}
  spec.homepage      = ""
  spec.license       = "AGPL"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
