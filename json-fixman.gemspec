# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json-fixman/version'

Gem::Specification.new do |gem|
  gem.name          = "json-fixman"
  gem.version       = Json::Fixman::VERSION
  gem.authors       = ["Shinpei Maruyama"]
  gem.email         = ["shinpeim@gmail.com"]
  gem.description   = "description"
  gem.summary       = "summary"
  gem.homepage      = "https://github.com/Shinpeim/json-fixman"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "json", "~> 1.5.4"
end
