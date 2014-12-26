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
      assert vtdomain_report.kind_of?(VirustotalAPI::DomainReport)
      assert vtdomain_report.report.kind_of?(Hash)
    end
  end

  def test_params
    VCR.use_cassette('domain_report') do
      vtdomain_report = VirustotalAPI::DomainReport.find(@domain, @api_key)

      assert vtdomain_report.api_uri.kind_of?(String)
      assert vtdomain_report.api_uri, 'https://www.virustotal.com/vtapi/v2/domain/report'
    end
  end

  def test_exists?
    VCR.use_cassette('domain_report') do
      vtdomain_report = VirustotalAPI::DomainReport.find(@domain, @api_key)

      assert vtdomain_report.exists?, true
    end
  end
end
