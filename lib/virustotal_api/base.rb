# frozen_string_literal: true

require 'virustotal_api/exceptions'
require 'rest-client'
require 'json'
require 'base64'

# The base VirustotalAPI module.
module VirustotalAPI
  # The base class implementing the raw calls to Virustotal API V3.
  class Base
    attr_reader :report

    def initialize(report)
      @report = report
    end

    # @return [String] string of API URI class method
    def self.api_uri
      VirustotalAPI::URI
    end

    # The actual method performing a call to Virustotal
    #
    # @param [String] url The url of the API
    # @param [String] api_key The key for virustotal
    # @param [String] method The HTTP method to use
    # @param [Hash] options Options to pass as payload
    # @return [VirustotalAPI::Domain] Report Search Result
    def self.perform(url, api_key, method = :get, options = {})
      response = RestClient::Request.execute(
        method: method,
        url: api_uri + url,
        headers: { 'x-apikey': api_key },
        payload: options
      )
      JSON.parse(response.body)
    rescue RestClient::NotFound
      nil
    rescue RestClient::Unauthorized
      # Raise a custom exception not to expose the underlying
      # HTTP client.
      raise VirustotalAPI::Unauthorized
    end

    # @return [String] string of API URI instance method
    def api_uri
      self.class.api_uri
    end

    # @return [Boolean] if report for resource exists
    def exists?
      !report.empty?
    end

    # Generate a URL identifier.
    # @see https://developers.virustotal.com/v3.0/reference#url
    def self.url_identifier(url)
      Base64.encode64(url).strip.gsub('=', '')
    end
  end
end
