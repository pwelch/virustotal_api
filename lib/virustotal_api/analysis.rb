# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  # A class for '/analyses' API
  class Analysis < Base
    attr_reader :report

    def initialize(report)
      @report = report
    end

    # @param [String] id The Virustotal ID to get the report for.
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::IP] Report
    def self.find(id, api_key)
      report = perform("/analyses/#{id}", api_key)
      new(report)
    end
  end
end
