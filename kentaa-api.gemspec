# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kentaa/api/version'

Gem::Specification.new do |spec|
  spec.name          = "kentaa-api"
  spec.version       = Kentaa::Api::VERSION
  spec.authors       = ["Kentaa"]
  spec.email         = ["support@kentaa.nl"]

  spec.summary       = "Ruby library for communicating with the Kentaa API"
  spec.homepage      = "https://github.com/KentaaNL/kentaa-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.3.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.3", ">= 2.3.2"
end
