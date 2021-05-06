# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIFileTest < Minitest::Test
  def setup
    @sha256    = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    @file_path = File.expand_path('test/fixtures/null_file')
    @api_key   = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::File
  end

  def test_report_response
    VCR.use_cassette('file_find') do
      vt_file_report = VirustotalAPI::File.find(@sha256, @api_key)

      # Make sure that the JSON was parsed
      assert vt_file_report.exists?
      assert vt_file_report.is_a?(VirustotalAPI::File)
      assert vt_file_report.report.is_a?(Hash)
      assert vt_file_report.id.is_a?(String)
      assert vt_file_report.report_url.is_a?(String)
    end
  end

  def test_find
    id        = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    permalink = "https://www.virustotal.com/api/v3/files/#{id}"

    VCR.use_cassette('file_find') do
      vt_file_report = VirustotalAPI::File.find(@sha256, @api_key)

      assert_equal permalink, vt_file_report.report_url
      assert_equal id, vt_file_report.id
      assert vt_file_report.detected_by('Avira')
      assert !vt_file_report.detected_by('Acronis')
      assert !vt_file_report.detected_by('Yeyeyeye') # not present in file
    end
  end

  def test_upload
    VCR.use_cassette('file_upload') do
      vt_file_upload = VirustotalAPI::File.upload(@file_path, @api_key)

      assert vt_file_upload.exists?
      assert vt_file_upload.report.is_a?(Hash)
      assert vt_file_upload.id.is_a?(String)
    end
  end

  def test_upload
    VCR.use_cassette('big_file_upload') do
      vt_file_upload = VirustotalAPI::File.upload_big(@file_path, @api_key)

      assert vt_file_upload.exists?
      assert vt_file_upload.report.is_a?(Hash)
      assert vt_file_upload.id.is_a?(String)
    end
  end

  def test_analyse
    VCR.use_cassette('file_analyse') do
      vt_file_analyse = VirustotalAPI::File.analyse(@sha256, @api_key)

      assert vt_file_analyse.exists?
      assert vt_file_analyse.report.is_a?(Hash)
      assert vt_file_analyse.id.is_a?(String)
    end
  end
end
