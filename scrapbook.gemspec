# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scrapbook/version"

Gem::Specification.new do |s|
  s.name        = "scrapbook"
  s.version     = Scrapbook::VERSION
  s.authors     = ["Christopher Griffith Studio","ContrarySheep"]
  s.email       = ["studio@christophergriffith.com","contrarysheep@gmail.com"]
  s.homepage    = "http://griffithstudio.github.com/scrapbook"
  s.summary     = %q{A ruby gem to store social media postings.}
  s.description = %q{A ruby gem to store social media postings.}
  
  s.rubyforge_project = "scrapbook"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # specify any dependencies here;
  s.add_dependency 'rails',   '>= 3.1'
    
  # specify development depencies here;

  # specify any runtime dependencies here;

end