# VirustotalAPI

Ruby Gem for [VirusTotal](https://www.virustotal.com) V2 [API](https://www.virustotal.com/en/documentation/public-api/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'virustotal_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install virustotal_api

## Usage

### Report

```ruby
require 'virustotal_api'

sha256  = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
api_key = 'MY_API_KEY'

vtreport = VirustotalAPI::File.find(sha256, api_key)

# Does the resource have any results?
vtreport.exists?
# => true

# URL for Report (if it exists)
vtreport.report_url
# => "https://www.virustotal.com/file/01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b/analysis/1418032127/"

# Report results (if they exist) are available via #report
vtreport.report["scans"]["ClamAV"]
# => {"detected"=>false, "version"=>"0.98.5.0", "result"=>nil, "update"=>"20141208"}
```

## Contributing

1. Fork it ( https://github.com/pwelch/virustotal_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
