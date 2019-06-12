# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  class FileReport < Base
    attr_reader :report, :report_url

    def initialize(report)
      @report     = report
      @report_url = report.fetch('permalink') { nil }
    end

    # @param [String] resource file as a md5/sha1/sha256 hash
    # @param [String] api_key for virustotal
    # @return [VirustotalAPI::FileReport] Report Search Result
    def self.find(resource, api_key)
      response = RestClient.post(
        api_uri + '/file/report',
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
        resource: resource,
        apikey: api_key
      }
    end
  end
end
