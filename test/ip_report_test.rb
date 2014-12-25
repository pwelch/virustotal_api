require './test/test_helper'

class VirustotalAPIIPReportTest < Minitest::Test
  def setup
    @ip      = '8.8.8.8'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::IPReport
  end

  def test_report_response
    VCR.use_cassette('ip_report') do
      vtip_report = VirustotalAPI::IPReport.find(@ip, @api_key)

      # Make sure that the JSON was parsed
      assert vtip_report.kind_of?(VirustotalAPI::IPReport)
      assert vtip_report.report.kind_of?(Hash)
    end
  end

  def test_params
    VCR.use_cassette('ip_report') do
      vtip_report = VirustotalAPI::IPReport.find(@ip, @api_key)

      assert vtip_report.api_uri.kind_of?(String)
      assert vtip_report.api_uri, 'https://www.virustotal.com/vtapi/v2/ip-address/report'
    end
  end

  def test_exists?
    VCR.use_cassette('ip_report') do
      vtip_report = VirustotalAPI::IPReport.find(@ip, @api_key)

      assert vtip_report.exists?, true
    end
  end
end
