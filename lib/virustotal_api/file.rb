# frozen_string_literal: true

require_relative 'base'

module VirustotalAPI
  # A class for '/files' API
  class File < Base
    # Find a hash.
    #
    # @param [String] resource file as a md5/sha1/sha256 hash
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::File] Report Search Result
    def self.find(resource, api_key)
      report = perform("/files/#{resource}", api_key)
      new(report)
    end

    # Upload a new file.
    #
    # @param [String] file_path for file to be sent for scan
    # @param [String] api_key The key for virustotal
    # @param [Hash] opts hash for additional options
    # @return [VirusotalAPI::File] Report
    def self.upload(file_path, api_key, opts = {})
      filename = opts.fetch('filename') { ::File.basename(file_path) }
      report = perform('/files', api_key, :post, filename: filename, file: ::File.open(file_path, 'r'))
      new(report)
    end

    # Analyse a hash again.
    #
    # @param [String] resource file as a md5/sha1/sha256 hash
    # @param [String] api_key The key for virustotal
    # @return [VirustotalAPI::File] Report
    def self.analyse(resource, api_key)
      report = perform("/files/#{resource}/analyse", api_key, :post)
      new(report)
    end

    # Check if the submitted hash is detected by an AV engine.
    #
    # @param [String] engine The engine to check.
    # @return [Boolean] true if detected
    def detected_by(engine)
      report&.dig('data', 'attributes', 'last_analysis_results', engine, 'category') == 'malicious'
    end
  end
end
