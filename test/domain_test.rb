# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIDomainTest < Minitest::Test
  def setup
    @domain  = 'virustotal.com'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::Domain
  end

  def test_report_response
    VCR.use_cassette('domain') do
      vtdomain_report = VirustotalAPI::Domain.find(@domain, @api_key)

      # Make sure that the JSON was parsed
      assert vtdomain_report.is_a?(VirustotalAPI::Domain)
      assert vtdomain_report.report.is_a?(Hash)
    end
  end

  def test_exists?
    VCR.use_cassette('domain') do
      vtdomain_report = VirustotalAPI::Domain.find(@domain, @api_key)

      assert vtdomain_report.exists?
    end
  end
end
