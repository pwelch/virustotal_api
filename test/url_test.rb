# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIURLReportTest < Minitest::Test
  def setup
    @unscanned_url = 'http://www.unscanned.com'
    @url           = 'http://www.google.com'
    @api_key       = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::URL
  end

  def test_report_response
    VCR.use_cassette('url_find') do
      vturl_report = VirustotalAPI::URL.find(@url, @api_key)

      # Make sure that the JSON was parsed
      assert vturl_report.exists?
      assert vturl_report.is_a?(VirustotalAPI::URL)
      assert vturl_report.report.is_a?(Hash)
      assert vturl_report.id.is_a?(String)
      assert vturl_report.report_url.is_a?(String)
    end
  end

  def test_scan_unscanned_url
    VCR.use_cassette('unscanned_url_find') do
      vturl_report = VirustotalAPI::URL.find(@unscanned_url, @api_key)

      assert !vturl_report.exists?
      assert_empty vturl_report.report
    end
  end

  def test_analyse
    VCR.use_cassette('url_analyse') do
      vturl_analyse = VirustotalAPI::URL.analyse(@url, @api_key)

      assert vturl_analyse.exists?
      assert vturl_analyse.report.is_a?(Hash)
      assert vturl_analyse.id.is_a?(String)
    end
  end
end
