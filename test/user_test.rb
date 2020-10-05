# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIUserReportTest < Minitest::Test
  def setup
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::User
  end

  def test_report_response
    VCR.use_cassette('user_find') do
      vtuser_report = VirustotalAPI::User.find(@api_key, @api_key)

      # Make sure that the JSON was parsed
      assert vtuser_report.is_a?(VirustotalAPI::User)
      assert vtuser_report.report.is_a?(Hash)
    end
  end

  def test_find
    VCR.use_cassette('user_find') do
      vtuser_report = VirustotalAPI::User.find(@api_key, @api_key)

      assert vtuser_report.report_url.is_a?(String)
    end
  end
end
