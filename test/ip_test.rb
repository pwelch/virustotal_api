# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIIPReportTest < Minitest::Test
  def setup
    @ip      = '8.8.8.8'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::IP
  end

  def test_report_response
    VCR.use_cassette('ip') do
      vtip_report = VirustotalAPI::IP.find(@ip, @api_key)

      # Make sure that the JSON was parsed
      assert vtip_report.is_a?(VirustotalAPI::IP)
      assert vtip_report.report.is_a?(Hash)
    end
  end
end
