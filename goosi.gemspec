# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'goosi/version'

Gem::Specification.new do |spec|
  spec.name = 'goosi'
  spec.version = Goosi::VERSION
  spec.authors = ['Mike Mulev']
  spec.email = ['m.mulev@gmail.com']

  spec.summary = 'Ruby toolkit for the Google Assistant API'
  spec.description = 'Goosi is a ruby toolkit for the Google Assistant API'
  spec.homepage = 'https://github.com/mulev/goosi'
  spec.license = 'MIT'

  spec.files = Dir['[A-Z]*'] + Dir['lib/**/*'] + Dir['tests/**'] + Dir['bin/**']
  spec.files.reject! { |fn| fn.include?('.gem') }
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'bundler', '~> 1.7'
  spec.add_runtime_dependency 'rake', '~> 12.0'
  spec.add_runtime_dependency 'oj', '~> 3.0'
  spec.add_development_dependency 'minitest', '~> 5.10', '>= 5.10.2'
  spec.add_development_dependency 'minitest-reporters', '~> 1.1', '>= 1.1.14'
end
