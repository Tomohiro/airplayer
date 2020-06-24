# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'airplayer/version'

Gem::Specification.new do |spec|
  spec.name          = 'airplayer'
  spec.version       = AirPlayer::VERSION
  spec.authors       = ['Tomohiro TAIRA']
  spec.email         = ['tomohiro.t@gmail.com']

  spec.summary       = 'Command-line AirPlay video client for Apple TV'
  spec.description   = 'Command-line AirPlay video client for Apple TV'
  spec.homepage      = 'https://github.com/Tomohiro/airplayer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}).map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # This gem will work with 2.2.0 or greater...
  spec.required_ruby_version = '>= 2.2.0'

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'ruby-progressbar'
  spec.add_runtime_dependency 'mime-types', '~> 2.4.0'

  spec.add_runtime_dependency 'airplay', '~> 1.0.2'
  spec.add_runtime_dependency 'rack', '>= 1.5', '< 2.3'
  spec.add_runtime_dependency 'http', '= 0.5.0'
  spec.add_runtime_dependency 'nio4r', '~> 1.1.0'
  spec.add_runtime_dependency 'reel', '= 0.4.0'
  spec.add_runtime_dependency 'reel-rack', '= 0.1.0'
  spec.add_runtime_dependency 'celluloid', '= 0.15.2'
  spec.add_runtime_dependency 'celluloid-io', '= 0.15.0'
  spec.add_runtime_dependency 'cuba', '= 3.1.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'fakefs'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'pry'
end
