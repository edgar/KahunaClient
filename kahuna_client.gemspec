# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kahuna_client/version'

Gem::Specification.new do |gem|
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.summary       = %q{A ruby wrapper for Kahuna Push API}
  gem.name          = "kahuna_client"
  gem.require_paths = ["lib"]
  gem.version       = KahunaClient::VERSION
  gem.license       = "MIT"

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'bluecloth'

  gem.add_dependency 'faraday', '~> 0.9.1'
  gem.add_dependency 'faraday_middleware', '~> 0.9.1'
  gem.add_dependency 'multi_json', '~> 1.11.0'
  gem.add_dependency 'hashie'
  gem.authors       = ["Edgar Gonzalez"]
  gem.email         = ["edgargonzalez@gmail.com"]
  gem.description   = %q{A ruby wrapper for Kahuna Push API}
  gem.homepage      = "http://github.com/edgar/KahunaClient"
end
