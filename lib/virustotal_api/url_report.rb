# encoding: utf-8
require_relative 'base'

module VirustotalAPI
  class URLReport < Base
    attr_reader :report, :report_url, :scan_id

    def initialize(report)
      @report     = report
      @report_url = report.fetch('permalink') { nil }
      @scan_id    = report.fetch('scan_id') { nil }
    end

    # @param [String] resource file as a md5/sha1/sha256 hash
    # @param [String] api_key for virustotal
    # @return [VirustotalAPI::URLReport] Report Search Result
    def self.find(resource, api_key)
      response = RestClient.post(
        api_uri + '/url/report',
        params(resource, api_key)
      )
      report = parse(response)

      new(report)
    end

    # @param [String] resource file as a md5/sha1/sha256 hash
    # @param [String] api_key for virustotal
    # @return [Hash] params for POST Request
    def self.params(resource, api_key)
      {
        :resource => resource,
        :apikey   => api_key
      }
    end
  end
end
