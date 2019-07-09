# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  class FileRescan < Base
    attr_reader :response, :rescan_id

    def initialize(response)
      @response  = JSON.parse(response)
      @rescan_id = @response.fetch('scan_id') { nil }
    end

    # @param [String] resource file as a md5/sha1/sha256 hash
    # @param [String] api_key for virustotal
    # @return [VirustotalAPI::FileRescan] Reponse
    def self.rescan(resource, api_key)
      response = RestClient.post(
        api_uri + '/file/rescan',
        apikey: api_key,
        resource: resource
      )

      new(response)
    end

    # @return [Boolean] if file was queued
    # 0 => not_present, 1 => exists, -2 => queued_for_analysis
    def queued_for_analysis?
      response_code = report.fetch('response_code') { nil }

      response_code == -2
    end
  end
end
