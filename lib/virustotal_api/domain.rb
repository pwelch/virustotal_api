# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  # A class for '/domains' API
  class Domain < Base
    def initialize(report)
      super(report)
    end

    # Find a domain.
    #
    # @param [String] domain The domain to search
    # @param [String] api_key for virustotal
    # @return [VirustotalAPI::Domain] Report Search Result
    def self.find(domain, api_key)
      report = perform("/domains/#{domain}", api_key)
      new(report)
    end
  end
end
