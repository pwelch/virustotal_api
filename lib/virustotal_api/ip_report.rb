require_relative 'base'

module VirustotalAPI
  class IPReport < Base
    attr_reader :report

    def initialize(report)
      @report = report
    end

    # @param [String] ip address IPv4 format
    # @param [String] api_key for virustotal
    # @return [VirustotalAPI::IPReport] Report Search Result
    def self.find(ip_address, api_key)
      response = RestClient.get(
        api_uri + '/ip-address/report',
        { :params => params(ip_address, api_key) }
      )
      report = parse(response)

      new(report)
    end

    # @param [String] ip address IPv4 format
    # @param [String] api_key for virustotal
    # @return [Hash] params for GET Request
    def self.params(ip_address, api_key)
      {
        :ip     => ip_address,
        :apikey => api_key
      }
    end
  end
end
