# coding: utf-8 lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glass/version'

Gem::Specification.new do |spec|
  spec.name          = "glass"
  spec.version       = Glass::VERSION
  spec.authors       = ["Adrian Peterson Co"]
  spec.email         = ["adrianpco@gmail.com"]
  spec.description   = %q{Glass}
  spec.summary       = %q{Glassy}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "rails"
  spec.add_dependency "json"
  spec.add_dependencykk
end
