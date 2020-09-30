# frozen_string_literal: true

require './test/test_helper'

class RateLimitErrorTest < Minitest::Test
  def setup
    @sha256 = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::RateLimitError
    assert VirustotalAPI::Unauthorized
  end

  def test_unauthorized
    VCR.use_cassette('file_unauthorized') do
      assert_raises VirustotalAPI::Unauthorized do
        VirustotalAPI::File.find(@sha256, @api_key)
      end
    end
  end

  def test_rate_limit
    VCR.use_cassette('file_rate_limit') do
      assert_raises VirustotalAPI::RateLimitError do
        VirustotalAPI::File.analyse(@sha256, @api_key)
      end
    end
  end
end
