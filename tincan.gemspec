# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tincan/version'

Gem::Specification.new do |gem|
  gem.name          = 'tincan'
  gem.version       = Tincan::VERSION
  gem.authors       = ['Sam Soffes']
  gem.email         = ['sam@soff.es']
  gem.description   = 'Phone number provider.'
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/seesawco/tincan'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 1.9.2'
  gem.add_dependency 'sinatra'
  gem.add_dependency 'sinatra-contrib'
  gem.add_dependency 'fakie'
  gem.add_dependency 'redis'
  gem.add_dependency 'redis-namespace'
  gem.add_dependency 'base62'
  gem.add_dependency 'multi_json'
end
