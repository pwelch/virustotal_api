# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIFileRescanTest < Minitest::Test
  # rubocop:disable LineLength
  def setup
    @sha256  = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::FileRescan
  end

  def test_rescan_response
    VCR.use_cassette('rescan') do
      virustotal_rescan = VirustotalAPI::FileRescan.rescan(@sha256, @api_key)

      assert virustotal_rescan.response.is_a?(Hash)
    end
  end

  def test_rescan_id
    VCR.use_cassette('rescan') do
      virustotal_rescan = VirustotalAPI::FileRescan.rescan(@sha256, @api_key)

      assert virustotal_rescan.rescan_id.is_a?(String)
    end
  end
  # rubocop:enable LineLength
end
