# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack/alive/version"

Gem::Specification.new do |s|
  s.name        = "rack-alive"
  s.version     = Rack::Alive::VERSION
  s.authors     = ["Merchii", "Jonas Grimfelt"]
  s.email       = ["jonas@merchii.com", "grimen@gmail.com"]
  s.homepage    = "http://github.com/merchii/rack-alive"
  s.summary     = %q{Rack middleware for checking if app is alive or not - optionally via custom condition(s).}
  s.description = s.summary

  s.rubyforge_project = s.name

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'rack'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'rack-test'
end
