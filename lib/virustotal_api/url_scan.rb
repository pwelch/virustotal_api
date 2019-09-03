# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  class URLScan < Base
    attr_reader :report, :scan_id

    def initialize(report)
      @report  = report
      @scan_id = @report.fetch('scan_id') { nil }
    end

    # @param [String] url
    # @param [String] api_key for virustotal
    # @return [VirustotalAPI::URLScan] Report
    def self.scan(url, api_key)
      response = RestClient.post(
        api_uri + '/url/scan',
        apikey: api_key,
        url: url
      )
      report = parse(response)

      new(report)
    end

    # @return [Boolean] if file was queued
    # 0 => not_present, 1 => exists, -2 => queued_for_analysis
    def queued_for_analysis?
      response_code = @report.fetch('response_code') { nil }

      response_code == -2
    end
  end
end
