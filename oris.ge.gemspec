# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oris.ge/version'

Gem::Specification.new do |gem|
  gem.name          = "oris.ge"
  gem.version       = Oris.ge::VERSION
  gem.authors       = ["Dimitri Kurashvili"]
  gem.email         = ["dimitri@c12.ge"]
  gem.description   = %q{Library for ORIS.GE accounting}
  gem.summary       = %q{Library for transfering data to and from ORIS.GE accounting software}
  gem.homepage      = "http://c12.ge"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

	s.add_development_dependency 'rspec', '~> 2'
end

