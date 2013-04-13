# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jsonpatcher/version'

Gem::Specification.new do |gem|
  gem.name          = "jsonpatcher"
  gem.version       = JSONPatcher::VERSION
  gem.authors       = ["Shinpei Maruyama"]
  gem.email         = ["shinpeim@gmail.com"]
  gem.description   = "patches bad json"
  gem.summary       = "jsopatcher provides DSL to patch semanticaly bad json"
  gem.homepage      = "https://github.com/Shinpeim/jsonpatcher"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "json", "~> 1.7.7"
  gem.add_development_dependency "rspec"
end
