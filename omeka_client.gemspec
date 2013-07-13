# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omeka_client/version'

Gem::Specification.new do |spec|
  spec.name          = "omeka_client"
  spec.version       = OmekaClient::VERSION
  spec.authors       = ["Lincoln Mullen"]
  spec.email         = ["lincoln@lincolnmullen.com"]
  spec.description   = %q{A REST client to access the Omeka API}
  spec.summary       = %q{A REST client to access the Omeka API}
  spec.homepage      = "https://github.com/lmullen/omeka_client"
  spec.license       = "GPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "yard"

  spec.add_dependency "rest", "~> 2.6.3"
end
