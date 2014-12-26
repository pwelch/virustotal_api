# encoding: utf-8
require 'rest-client'
require 'json'

module VirustotalAPI
  class DomainReport
    attr_reader :report

    def initialize(report)
      @report = report
    end

    # @param [String] Domain
    # @param [String] Virustotal API Key
    # @return [VirustotalAPI::IPReport] Report Search Result
    def self.find(domain, api_key)
      response = RestClient.get(
        api_uri,
        { :params => params(domain, api_key) }
      )
      report = JSON.parse(response.body)

      new(report)
    end

    # @param [String] IPv4 Domain
    # @param [String] Virustotal API Key
    # @return [Hash] for GET Request
    def self.params(domain, api_key)
      {
        :domain => domain,
        :apikey => api_key
      }
    end

    # @return [String] of API URI
    def self.api_uri
      @_api_uri ||= VirustotalAPI::URI + '/domain/report'
    end

    # @return [String] instance method of API URI
    def api_uri
      self.class.api_uri
    end

    # @return [Boolean] if report for resource exists
    # 0 => not_present, 1 => exists, -1 => invalid_ip_address
    def exists?
      response_code = report.fetch('response_code') { nil }

      response_code == 1 ? true : false
    end
  end
end
