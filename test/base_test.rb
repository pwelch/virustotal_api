# frozen_string_literal: true

# rubocop:disable LineLength
require './test/test_helper'

class VirustotalAPIBaseTest < Minitest::Test
  def setup
    @sha256  = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::Base
  end

  # Instance Method
  def test_api_uri_instance_method
    base_uri = 'https://www.virustotal.com/vtapi/v2'
    vt_base = VirustotalAPI::Base.new

    assert vt_base.api_uri.is_a?(String)
    assert vt_base.api_uri, base_uri
  end

  # Class Method
  def test_api_uri_class_method
    base_uri = 'https://www.virustotal.com/vtapi/v2'

    assert VirustotalAPI::Base.api_uri.is_a?(String)
    assert VirustotalAPI::Base.api_uri, base_uri
  end

  def test_parse_code_200
    mock_response200 = Minitest::Mock.new
    mock_response200.expect(:code, 200)
    mock_response200.expect(:body, '{}')

    assert VirustotalAPI::Base.parse(mock_response200), {}
  end

  def test_parse_code_204
    mock_response204 = Minitest::Mock.new
    mock_response204.expect(:code, 204)
    mock_response204.expect(:body, '{}')

    assert_raises VirustotalAPI::RateLimitError do
      VirustotalAPI::Base.parse(mock_response204)
    end
  end

  # Test using FileReport
  def test_exists?
    VCR.use_cassette('report') do
      virustotal_report = VirustotalAPI::FileReport.find(@sha256, @api_key)

      assert virustotal_report.exists?, true
    end
  end
end
