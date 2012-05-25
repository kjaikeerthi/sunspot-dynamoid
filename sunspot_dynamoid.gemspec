# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sunspot/version"

Gem::Specification.new do |s|
  s.name        = "sunspot_dynamoid"
  s.version     = Sunspot::VERSION
  s.authors     = ["Jai Keerthi"]
  s.email       = ["me@jaikeerthi.in"]
  s.homepage    = ""
  s.summary     = %q{""}
  s.description = %q{""}

  s.rubyforge_project = "sunspot_dynamoid"

  s.files         = [
    'Gemfile',
    'Rakefile',
    'lib/sunspot_dynamoid.rb',
    'lib/sunspot/dynamoid.rb',
    'lib/sunspot/keygen.rb',
    'lib/sunspot/version.rb',
    'sunspot_dynamoid.gemspec'
  ]
    `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
