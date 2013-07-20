# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'config_env/version'

Gem::Specification.new do |spec|
  spec.name          = 'config_env'
  spec.version       = ConfigEnv::VERSION
  spec.authors       = ['Sergey Makridenkov']
  spec.email         = ['sergey@makridenkov.com']
  spec.description   = %q{Manage ENV[] variables, upload ENV to Heroku}
  spec.summary       = %q{Manage ENV[] variables, upload ENV to Heroku}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rerun'
end
