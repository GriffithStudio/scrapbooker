# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scrapbooker/version"

Gem::Specification.new do |s|
  s.name        = "scrapbooker"
  s.version     = Scrapbooker::VERSION
  s.authors     = ["Christopher Griffith Studio","ContrarySheep"]
  s.email       = ["studio@christophergriffith.com","contrarysheep@gmail.com"]
  s.homepage    = "http://griffithstudio.github.com/scrapbooker"
  s.summary     = %q{Scrapbooker saves social media feeds locally.}
  s.description = %q{Scrapbooker is a gem for rails that allows you to pull information from social media feeds then store the information locally.}
  
  s.rubyforge_project = "scrapbooker"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # specify any dependencies here;
  s.add_dependency 'rails',   '>= 3.0'
  s.add_dependency 'json'
  s.add_dependency 'twitter'
    
  # specify development depencies here;
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'vcr', '~> 2.0.0'
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'sqlite3'

  # specify any runtime dependencies here;

end