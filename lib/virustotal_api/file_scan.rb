# encoding: utf-8
require 'json'
require 'rest-client'

module VirustotalAPI
  class FileScan
    attr_reader :response, :scan_id

    def initialize(response)
      @response = JSON.parse(response)
      @scan_id  = @response.fetch('scan_id') { nil }
    end

    # @param [String] file path
    # @param [String] Virustotal API Key
    # @param [Hash] Options Hash
    # @return [VirusotalAPIFileScan] Reponse
    def self.scan(file_path, api_key, opts = {})
      response = RestClient.post(
        api_uri,
        :apikey   => api_key,
        :filename => opts.fetch('filename') { File.basename(file_path) },
        :file     => File.open(file_path, 'r')
      )

      new(response)
    end

    # @return [String] of API URI
    def self.api_uri
      @api_uri ||= VirustotalAPI::URI + '/file/scan'
    end

    # @return [String] instance method of API URI
    def api_uri
      self.class.api_uri
    end

    # @return [Boolean] if report for file exists
    # 0 => not_present, 1 => exists, -2 => queued_for_analysis
    def exists?
      response_code = response.fetch('response_code') { nil }

      response_code == 1 ? true : false
    end

    # @return [Boolean] if file was queued
    # 0 => not_present, 1 => exists, -2 => queued_for_analysis
    def queued_for_analysis?
      response_code = report.fetch('response_code') { nil }

      response_code == -2 ? true : false
    end
  end
end
