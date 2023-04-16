# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pianobar_notify/version'

Gem::Specification.new do |spec|
  spec.name          = "pianobar_notify"
  spec.version       = PianobarNotify::VERSION
  spec.authors       = ["Juan C. Müller"]
  spec.email         = ["jcmuller@gmail.com"]
  spec.summary       = %q{Pianobar event_command driver}
  spec.homepage      = "https://github.com/jcmuller/pianobar_notify"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "binding_of_caller"

  spec.add_runtime_dependency "libnotify"
  spec.add_runtime_dependency "mini_magick"
end
