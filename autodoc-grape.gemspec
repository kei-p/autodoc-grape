# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autodoc/grape/version'

Gem::Specification.new do |spec|
  spec.name          = "autodoc-grape"
  spec.version       = Autodoc::Grape::VERSION
  spec.authors       = ["Keisuke Ishizawa"]
  spec.email         = ["muddyapesjm66@gmail.com"]

  spec.summary       = "Autodoc for Grape API specs."
  spec.homepage      = "https://github.com/kei-p/autodoc-grape"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "autodoc"
  spec.add_dependency "grape", '>= 0.14.0'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rails", "4.2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency 'appraisal'
end
