# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  # A class for '/users' API
  class User < Base
    attr_reader :report_url, :id

    def initialize(report)
      super(report)
      @report_url = report&.dig('data', 'links', 'self')
      @id = report&.dig('data', 'id')
    end

    # Find a User.
    #
    # @param [String] user_key with id or api_key
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::User] Report
    def self.find(user_key, api_key)
      report = perform("/users/#{user_key}", api_key)
      new(report)
    end
  end
end
