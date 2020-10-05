# VirustotalAPI

Ruby Gem for [VirusTotal](https://www.virustotal.com) [V3 API](https://developers.virustotal.com/v3.0/reference).
If you want the version 2, check out the gem versions up to [0.4.0](https://github.com/crondaemon/virustotal_api/tree/v0.4.0).

![Ruby](https://github.com/pwelch/virustotal_api/workflows/Ruby/badge.svg)

[![Gem Version](https://badge.fury.io/rb/virustotal_api.svg)](http://badge.fury.io/rb/virustotal_api)

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

### File Find

```ruby
require 'virustotal_api'

sha256  = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
api_key = 'MY_API_KEY'

vtreport = VirustotalAPI::File.find(sha256, api_key)

# Does the resource have any results?
vtreport.exists?
# => true

# URL for File Report (if it exists)
vtreport.report_url
# => "https://www.virustotal.com/api/v3/files/01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b"

# Report results (if they exist) are available via #report
vtreport.report['data']['attributes']['last_analysis_results']['ClamAV']
# => {"category"=>"undetected", "engine_name"=>"ClamAV", "engine_update"=>"20200826",
# "engine_version"=>"0.102.4.0", "method"=>"blacklist", "result"=>nil}

# Check whether an Antivirus detected this sample or not
vtreport.detected_by('ClamAV')
# => false
```

### File Upload

```ruby
require 'virustotal_api'

file    = '/path/to/file'
api_key = 'MY_API_KEY'

vtscan = VirustotalAPI::File.upload(file, api_key)

# Virustotal ID of file
vtscan.id
# => "01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b-1419454668"

# Response results are available via #response
vtscan.report
# =>
{"data"=>
  {"id"=>"MTkxNDBmMjU4ZGY1OGZiYzZjNmU2ODcyMWNhYjhkZTM6MTU5ODUzMTE5OQ==",
   "type"=>"analysis"}}
```

### File Analyse

```ruby
require 'virustotal_api'

sha256  = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
api_key = 'MY_API_KEY'

vtrescan = VirustotalAPI::File.analyse(sha256, api_key)

# Virustotal ID of file
vtrescan.id
# => "MTkxNDBmMjU4ZGY1OGZiYzZjNmU2ODcyMWNhYjhkZTM6MTU5ODUzMTE5OQ=="

# Response results are available via #response
vtrescan.report
# =>
{"data"=>
  {"id"=>"MTkxNDBmMjU4ZGY1OGZiYzZjNmU2ODcyMWNhYjhkZTM6MTU5ODUzMTE5OQ==",
   "type"=>"analysis"}}
```

### URL find

```ruby
require 'virustotal_api'

url     = 'http://www.google.com'
api_key = 'MY_API_KEY'

vturl_report = VirustotalAPI::URL.find(url, api_key)

# Does the resource have any results?
vturl_report.exists?
# => true

# URL for Report (if it exists)
vturl_report.report_url
# => "https://www.virustotal.com/api/v3/urls/dd014af5ed6b38d9130e3f466f850e46d21b951199d53a18ef29ee9341614eaf/"

# Report results (if they exist) are available via #report
vturl_report.report['data']['attributes']['last_analysis_results']['Avira']
# => {"category"=>"harmless", "engine_name"=>"Avira", "method"=>"blacklist", "result"=>"clean"}
```

### URL Upload

```ruby
require 'virustotal_api'

url     = 'http://www.google.com'
api_key = 'MY_API_KEY'

vturl_scan = VirustotalAPI::URL.upload(url, api_key)

# Virustotal ID of file
vturl_scan.id
# => "u-dd014af5ed6b38d9130e3f466f850e46d21b951199d53a18ef29ee9341614eaf-1598531929"

# Response results are available via #response
vturl_scan.report
# =>
{"data"=>
  {"id"=>
    "u-dd014af5ed6b38d9130e3f466f850e46d21b951199d53a18ef29ee9341614eaf-1598531929",
   "type"=>"analysis"}}
```

### IP Find

```ruby
require 'virustotal_api'

ip      = '8.8.8.8'
api_key = 'MY_API_KEY'

vtip_report = VirustotalAPI::IP.find(ip, api_key)

# Does the resource have any results?
vtip_report.exists?
# => true

# Report results (if they exist) are available via #report
vtip_report.report
# => Hash of report results
```

### Domain Find

```ruby
require 'virustotal_api'

domain  = 'virustotal.com'
api_key = 'MY_API_KEY'

vtdomain_report = VirustotalAPI::Domain.find(domain, api_key)

# Does the resource have any results?
vtdomain_report.exists?
# => true

# Report results (if they exist) are available via #report
vtdomain_report.report
# => Hash of report results
```

### User Find

```ruby
require 'virustotal_api'

user_key  = 'user_key' # user_id or api_key
api_key = 'MY_API_KEY'

vtuser_report = VirustotalAPI::User.find(user_key, api_key)

# Does the resource have any results?
vtuser_report.exists?
# => true

# Report results (if they exist) are available via #report
vtuser_report.report
# => Hash of report results
```

### Group Find

```ruby
require 'virustotal_api'

group_id  = 'GROUP_id'
api_key = 'MY_API_KEY'

vtgroup_report = VirustotalAPI::Group.find(group_id, api_key)

# Does the resource have any results?
vtgroup_report.exists?
# => true

# Report results (if they exist) are available via #report
vtgroup_report.report
# => Hash of report results
```

## Contributors

- [@postmodern](https://github.com/postmodern)
- [@mkunkel](https://github.com/mkunkel)
- [@jonnynux](https://github.com/jonnynux)
- [@crondaemon](https://github.com/crondaemon/)

## Contributing

1. Fork it ( https://github.com/pwelch/virustotal_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
