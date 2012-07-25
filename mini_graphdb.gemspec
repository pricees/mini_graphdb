# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mini_graphdb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Edward Price"]
  gem.email         = ["ted.price+minigraphdb@gmail.com"]
  gem.description   = %q{Toy graph database for ruby}
  gem.summary       = %q{Toy graph database for ruby}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mini_graphdb"
  gem.require_paths = ["lib"]
  gem.version       = MiniGraphdb::VERSION
end
