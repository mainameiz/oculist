# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oculist/version'

Gem::Specification.new do |gem|
  gem.name          = "oculist"
  gem.version       = Oculist::VERSION
  gem.authors       = ["Nikolay Markov"]
  gem.email         = ["mainameiz@gmail.com"]
  gem.description   = %q{Provides ability to define required and optional parameters for controllers' actions in Ruby On Rails (with type casting and conditions)}
  gem.summary       = %q{Controller parameters filtering is Rails}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rails', '~> 3.2.0'
end
