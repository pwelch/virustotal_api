# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  # A class for '/groups' API
  class Group < Base
    # Find a Group.
    #
    # @param [String] group_id to find
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::User] Report
    def self.find(group_id, api_key)
      report = perform("/groups/#{group_id}", api_key)
      new(report)
    end
  end
end
