# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  class URLReport < Base
    attr_reader :report, :report_url, :scan_id

    def initialize(report)
      @report     = report
      @report_url = report.fetch('permalink') { nil }
      @scan_id    = report.fetch('scan_id') { nil }
    end

    # @param [String] resource as an ip/domain/url
    # @param [String] api_key for virustotal
    # @param [Integer] optional param to start scan if not found. 1 for true
    # @return [VirustotalAPI::URLReport] Report Search Result
    def self.find(resource, api_key, scan = 0)
      response = RestClient.post(
        api_uri + '/url/report',
        params(resource, api_key, scan)
      )
      report = parse(response)

      new(report)
    end

    # @param [String] resource as an ip/domain/url
    # @param [String] api_key for virustotal
    # @param [Integer] optional param to start scan if not found. 1 for true
    # @return [Hash] params for POST Request
    def self.params(resource, api_key, scan = 0)
      {
        resource: resource,
        apikey: api_key,
        scan: scan.to_s
      }
    end
  end
end
