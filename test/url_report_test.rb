require './test/test_helper'

class VirustotalAPIURLReportTest < Minitest::Test
  def setup
    @url     = 'http://www.google.com'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::URLReport
  end

  def test_report_response
    VCR.use_cassette('url_report') do
      vturl_report = VirustotalAPI::URLReport.find(@url, @api_key)

      # Make sure that the JSON was parsed
      assert vturl_report.is_a?(VirustotalAPI::URLReport)
      assert vturl_report.report.is_a?(Hash)
    end
  end

  def test_report_url
    VCR.use_cassette('url_report') do
      vturl_report = VirustotalAPI::URLReport.find(@url, @api_key)

      assert vturl_report.report_url.is_a?(String)
    end
  end

  def test_scan_url
    VCR.use_cassette('url_report') do
      vturl_report = VirustotalAPI::URLReport.find(@url, @api_key)

      assert vturl_report.scan_id.is_a?(String)
    end
  end
end
