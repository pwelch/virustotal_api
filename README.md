# VirustotalAPI

Ruby Gem for [VirusTotal](https://www.virustotal.com) [V2 API](https://www.virustotal.com/en/documentation/public-api/)

[![Gem Version](https://badge.fury.io/rb/virustotal_api.svg)](http://badge.fury.io/rb/virustotal_api)
[![Build Status](https://secure.travis-ci.org/pwelch/virustotal_api.svg)](http://travis-ci.org/pwelch/virustotal_api)

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

VirusTotal only allows 4 queries per minute for their Public API. https://www.virustotal.com/en/faq/

You will need a Private API Key if you require more queries per minute.

### File Report

```ruby
require 'virustotal_api'

sha256  = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
api_key = 'MY_API_KEY'

vtreport = VirustotalAPI::FileReport.find(sha256, api_key)

# Does the resource have any results?
vtreport.exists?
# => true

# URL for File Report (if it exists)
vtreport.report_url
# => "https://www.virustotal.com/file/01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b/analysis/1418032127/"

# Report results (if they exist) are available via #report
vtreport.report["scans"]["ClamAV"]
# => {"detected"=>false, "version"=>"0.98.5.0", "result"=>nil, "update"=>"20141208"}
```

### File Scan

```ruby
require 'virustotal_api'

file    = '/path/to/file'
api_key = 'MY_API_KEY'

vtscan = VirustotalAPI::FileScan.scan(file, api_key)

# Scan ID of file
vtscan.scan_id
# => "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b-1419454668"

# Response results are available via #response
vtreport.response
# =>
{
  "scan_id"=>"01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b-1419454668",
  "sha1"=>"adc83b19e793491b1c6ea0fd8b46cd9f32e592fc",
  "resource"=>"01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b",
  "response_code"=>1,
  "sha256"=>"01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b",
  "permalink"=>"https://www.virustotal.com/file/01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b/analysis/1419454668/",
  "md5"=>"68b329da9893e34099c7d8ad5cb9c940",
  "verbose_msg"=>"Scan request successfully queued, come back later for the report"
}
```

### URL Report

```ruby
require 'virustotal_api'

url     = 'http://www.google.com'
api_key = 'MY_API_KEY'

vturl_report = VirustotalAPI::URLReport.find(url, api_key)

# Does the resource have any results?
vturl_report.exists?
# => true

# URL for Report (if it exists)
vturl_report.report_url
# => "https://www.virustotal.com/url/dd014af5ed6b38d9130e3f466f850e46d21b951199d53a18ef29ee9341614eaf/analysis/1419457210/"

# Report results (if they exist) are available via #report
vturl_report.report["scans"]["Opera"]
# => {"detected"=>false, "result"=>"clean site"}
```

### IP Report

```ruby
require 'virustotal_api'

ip      = '8.8.8.8'
api_key = 'MY_API_KEY'

vtip_report = VirustotalAPI::IPReport.find(ip, api_key)

# Does the resource have any results?
vtip_report.exists?
# => true

# Report results (if they exist) are available via #report
vtip_report.report
# => Hash of report results
```

### Domain Report

```ruby
require 'virustotal_api'

domain  = 'virustotal.com'
api_key = 'MY_API_KEY'

vtdomain_report = VirustotalAPI::DomainReport.find(domain, api_key)

# Does the resource have any results?
vtdomain_report.exists?
# => true

# Report results (if they exist) are available via #report
vtdomain_report.report
# => Hash of report results
```

## Contributing

1. Fork it ( https://github.com/pwelch/virustotal_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
