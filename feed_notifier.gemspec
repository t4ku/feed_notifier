# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feed_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = "feed_notifier"
  spec.version       = FeedNotifier::VERSION
  spec.authors       = ["'Taku Okawa'"]
  spec.email         = ["'taku.okawa@gmail.com'"]
  spec.description   = %q{Notify feed update via notification center}
  spec.summary       = %q{Notify feed update via notification center}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/*_spec.rb})
  spec.require_paths = ["lib"]

  spec.add_dependency 'feedzirra','~> 0.1.3'
  spec.add_dependency 'lunchy','~> 0.7.0'
  spec.add_dependency 'terminal-notifier','~> 1.5.1'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
end
