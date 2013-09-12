# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glass/version'

Gem::Specification.new do |spec|
  spec.name          = "glass-api"
  spec.version       = Glass::VERSION
  spec.authors       = ["Adrian Peterson Co, Jaune Sarmiento, Robbie Marcelo"]
  spec.email         = ["adrianpco@gmail.com, hawnecarlo@gmail.com, rbmrclo@hotmail.com"]
  spec.description   = %q{Glass - A lightweight Rails Engine for an open RESTful API for models}
  spec.summary       = %q{Glass is a your one-stop solution for a RESTFUL API. It is a lightweight Rails Engine that is built to do all the heavy lifting from serving an API in your Rails Application.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "rails"
  spec.add_dependency "json"
end
