# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  # A class for '/urls' API
  class URL < Base
    # Find a URL.
    #
    # @param [String] resource as an ip/domain/url
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::URL] Report
    def self.find(resource, api_key)
      report = perform("/urls/#{url_identifier(resource)}", api_key)
      new(report)
    end

    # Analyse a URL again.
    #
    # @param [String] resource as an ip/domain/url
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::URL] Report
    def self.analyse(resource, api_key)
      report = perform("/urls/#{url_identifier(resource)}/analyse", api_key, :post)
      new(report)
    end

    # Upload a URL for detection.
    #
    # @param [String] resource as an ip/domain/url
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::URL] Report
    def self.upload(resource, api_key)
      report = perform('/urls', api_key, :post, url: resource)
      new(report)
    end
  end
end
