# frozen_string_literal: true

require 'virustotal_api/exceptions'
require 'rest-client'
require 'json'
require 'base64'

# The base VirustotalAPI module.
module VirustotalAPI
  # The base class implementing the raw calls to Virustotal API V3.
  class Base
    attr_reader :report, :report_url, :id

    def initialize(report)
      @report     = report
      @report_url = report&.dig('data', 'links', 'self')
      @id         = report&.dig('data', 'id')
    end

    # @return [String] string of API URI class method
    def self.api_uri
      VirustotalAPI::URI
    end

    def self.perform(path, api_key, method = :get, options = {})
      base_perform(api_uri + path, api_key, method, options)
    end

    def self.perform_absolute(url, api_key, method = :get, options = {})
      base_perform(url, api_key, method, options)
    end

    # The actual method performing a call to Virustotal
    #
    # @param [String] url The url of the API
    # @param [String] api_key The key for virustotal
    # @param [String] method The HTTP method to use
    # @param [Hash] options Options to pass as payload
    # @return [VirustotalAPI::Domain] Report Search Result
    def self.base_perform(url, api_key, method = :get, options = {})
      response = RestClient::Request.execute(
        method: method,
        url: url,
        headers: { 'x-apikey': api_key },
        payload: options
      )
      JSON.parse(response.body)
    rescue RestClient::NotFound, RestClient::BadRequest
      {}
    rescue RestClient::Unauthorized
      # Raise a custom exception not to expose the underlying
      # HTTP client.
      raise VirustotalAPI::Unauthorized
    rescue RestClient::TooManyRequests
      # Raise a custom exception not to expose the underlying
      # HTTP client.
      raise VirustotalAPI::RateLimitError
    end

    private_class_method :base_perform

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
      Base64.strict_encode64(url).strip.gsub('=', '')
    end
  end
end
