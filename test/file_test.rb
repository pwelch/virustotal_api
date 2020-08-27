# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIFileTest < Minitest::Test
  def setup
    @sha256 = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    @file_path = File.expand_path('test/fixtures/null_file')
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::File
  end

  def test_report_response
    VCR.use_cassette('file_find') do
      virustotal_report = VirustotalAPI::File.find(@sha256, @api_key)

      # Make sure that the JSON was parsed
      assert virustotal_report.is_a?(VirustotalAPI::File)
      assert virustotal_report.report.is_a?(Hash)
    end
  end

  def test_find
    permalink = 'https://www.virustotal.com/api/v3/files/' \
                '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    VCR.use_cassette('file_find') do
      virustotal_report = VirustotalAPI::File.find(@sha256, @api_key)

      assert virustotal_report.report_url.is_a?(String)
      assert_equal permalink, virustotal_report.report_url
    end
  end

  def test_upload
    VCR.use_cassette('file_upload') do
      virustotal_upload = VirustotalAPI::File.upload(@file_path, @api_key)

      assert virustotal_upload.report.is_a?(Hash)
    end
  end

  def test_upload_id
    VCR.use_cassette('file_upload') do
      virustotal_upload = VirustotalAPI::File.upload(@file_path, @api_key)

      assert virustotal_upload.id.is_a?(String)
    end
  end

  def test_analyse
    VCR.use_cassette('file_analyse') do
      virustotal_analyse = VirustotalAPI::File.analyse(@sha256, @api_key)

      assert virustotal_analyse.report.is_a?(Hash)
    end
  end

  def test_analyse_id
    VCR.use_cassette('file_analyse') do
      virustotal_analyse = VirustotalAPI::File.analyse(@sha256, @api_key)

      assert virustotal_analyse.id.is_a?(String)
    end
  end
end
