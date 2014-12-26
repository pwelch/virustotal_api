# encoding: utf-8
require_relative 'base'

module VirustotalAPI
  class DomainReport < Base
    attr_reader :report

    def initialize(report)
      @report = report
    end

    # @param [String] domain
    # @param [String] api_key for virustotal
    # @return [VirustotalAPI::IPReport] Report Search Result
    def self.find(domain, api_key)
      response = RestClient.get(
        api_uri + '/domain/report',
        { :params => params(domain, api_key) }
      )
      report = JSON.parse(response.body)

      new(report)
    end

    # @param [String] domain
    # @param [String] api_key virustotal
    # @return [Hash] params for GET Request
    def self.params(domain, api_key)
      {
        :domain => domain,
        :apikey => api_key
      }
    end
  end
end
