require 'virustotal_api/exceptions'
require 'rest-client'
require 'json'

module VirustotalAPI
  class Base
    # @return [String] string of API URI class method
    def self.api_uri
      VirustotalAPI::URI
    end

    # @param [RestClient::Response] response
    # @return [Hash] the parsed JSON.
    def self.parse(response)
      if response.code == 204
        raise(RateLimitError, 'maximum number of 4 requests per minute reached')
      end

      JSON.parse(response.body)
    end

    # @return [String] string of API URI instance method
    def api_uri
      self.class.api_uri
    end

    # @return [Boolean] if report for resource exists
    # 0 => not_present, 1 => exists, -1 => invalid_ip_address
    def exists?
      response_code = report.fetch('response_code') { nil }

      response_code == 1
    end
  end
end
