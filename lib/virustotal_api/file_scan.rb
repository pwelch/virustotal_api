# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  class FileScan < Base
    attr_reader :report, :scan_id

    def initialize(report)
      @report  = report
      @scan_id = @report.fetch('scan_id') { nil }
    end

    # @param [String] file_path for file to be sent for scan
    # @param [String] api_key for virustotal
    # @param [Hash] opts hash for additional options
    # @return [VirusotalAPI::FileScan] Report
    def self.scan(file_path, api_key, opts = {})
      response = RestClient.post(
        api_uri + '/file/scan',
        apikey: api_key,
        filename: opts.fetch('filename') { File.basename(file_path) },
        file: File.open(file_path, 'r')
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
