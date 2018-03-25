
require './test/test_helper'

class VirustotalAPIDomainReportTest < Minitest::Test
  def setup
    @domain  = 'virustotal.com'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::DomainReport
  end

  def test_report_response
    VCR.use_cassette('domain_report') do
      vtdomain_report = VirustotalAPI::DomainReport.find(@domain, @api_key)

      # Make sure that the JSON was parsed
      assert vtdomain_report.is_a?(VirustotalAPI::DomainReport)
      assert vtdomain_report.report.is_a?(Hash)
    end
  end

  def test_exists?
    VCR.use_cassette('domain_report') do
      vtdomain_report = VirustotalAPI::DomainReport.find(@domain, @api_key)

      assert vtdomain_report.exists?, true
    end
  end
end
