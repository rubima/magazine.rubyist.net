# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'randexp/multibyte/version'

Gem::Specification.new do |spec|
  spec.name          = "randexp-multibyte"
  spec.version       = Randexp::Multibyte::VERSION
  spec.authors       = ["Naoki Shimizu"]
  spec.email         = ["deme0607@gmail.com"]
  #spec.summary      = %q{TODO: Write a short summary. Required.}
  spec.summary       = %q{randexp extension for multibyte characters}
  #spec.description  = %q{TODO: Write a longer description. Optional.}
  spec.description   = %q{randexp extension for multibyte characters}
  #spec.homepage     = ""
  spec.homepage      = "https://github.com/deme0607/randexp-multibyte"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  #追記
  spec.add_dependency "randexp"
end

