# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "block_hash/version"

Gem::Specification.new do |s|
  s.name        = "block_hash"
  s.version     = BlockHash::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Maurycy Pawlowski-Wieronski"]
  s.email       = ["maurycy@g.pl"]
  s.homepage    = "https://github.com/maurycy/block_hash"
  s.summary		= %w{Evaluate a block to a hash}

  s.rubyforge_project = "block_hash"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
