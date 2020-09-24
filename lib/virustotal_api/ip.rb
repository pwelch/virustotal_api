# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  # A class for '/ip_addresses' API
  class IP < Base
    # rubocop:disable Lint/UselessMethodDefinition
    def initialize(report)
      super(report)
    end

    # Find an IP.
    #
    # @param [String] ip address The IP to find.
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::IPReport] Report
    def self.find(ip, api_key)
      report = perform("/ip_addresses/#{ip}", api_key)
      new(report)
    end
  end
end
# rubocop:enable Lint/UselessMethodDefinition
