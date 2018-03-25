lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'virustotal_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'virustotal_api'
  spec.version       = VirustotalAPI::VERSION
  spec.authors       = ['pwelch']
  spec.email         = ['paul@pwelch.net']
  spec.summary       = 'Gem for VirusTotal.com API'
  spec.description   = 'Gem for VirusTotal.com API'
  spec.homepage      = 'https://github.com/pwelch/virustotal_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'json'
  spec.add_dependency 'rest-client'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'yard', '~> 0.8'
end
