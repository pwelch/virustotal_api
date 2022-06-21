# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'virustotal_api/version'

Gem::Specification.new do |spec|
  spec.name        = 'virustotal_api'
  spec.version     = VirustotalAPI::VERSION
  spec.authors     = ['pwelch']
  spec.email       = ['git@welch.pw']
  spec.summary     = 'Gem for VirusTotal.com API'
  spec.description = 'Gem for VirusTotal.com API, supporting API V3'
  spec.homepage    = 'https://github.com/pwelch/virustotal_api'
  spec.license     = 'MIT'
  
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri']          = spec.homepage
    spec.metadata['source_code_uri']       = 'https://github.com/pwelch/virustotal_api'
    spec.metadata['changelog_uri']         = 'https://github.com/pwelch/virustotal_api/blob/main/CHANGELOG.md'
    spec.metadata['rubygems_mfa_required'] = 'true'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.required_ruby_version = '>= 2.7'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'json', '~> 2.3', '>= 2.3.1'
  spec.add_dependency 'rest-client', '~> 2.1', '>= 2.1.0'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'minitest', '~> 5.14', '>= 5.14.1'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.91'
  spec.add_development_dependency 'vcr', '~> 6.0', '>= 6.0.0'
  spec.add_development_dependency 'webmock', '~> 3.9'
  spec.add_development_dependency 'yard', '~> 0.9'
end
