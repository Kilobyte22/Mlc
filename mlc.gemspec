# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mlc/version'

Gem::Specification.new do |spec|
  spec.name          = 'mlc'
  spec.version       = Mlc::VERSION
  spec.authors       = ['Kilobyte']
  spec.email         = ['stiepen22@gmx.de']
  spec.description   = %q{Moonstone Lua Compiler}
  spec.summary       = %q{I can compile ruby to lua}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'ruby_parser'
end
