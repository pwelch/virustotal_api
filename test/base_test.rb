# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIBaseTest < Minitest::Test
  def setup
    @domain  = 'xpressco.za'
    @sha256  = '01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::Base
  end

  # Instance Method
  def test_api_uri_instance_method
    base_uri = 'https://www.virustotal.com/api/v3'
    vt_base = VirustotalAPI::Base.new(nil)

    assert vt_base.api_uri.is_a?(String)
    assert_equal base_uri, vt_base.api_uri
  end

  # Class Method
  def test_api_uri_class_method
    base_uri = 'https://www.virustotal.com/api/v3'

    assert VirustotalAPI::Base.api_uri.is_a?(String)
    assert_equal base_uri, VirustotalAPI::Base.api_uri
  end

  def test_exists?
    VCR.use_cassette('file_find') do
      virustotal_report = VirustotalAPI::File.find(@sha256, @api_key)

      assert virustotal_report.exists?
    end
  end

  def test_not_exists?
    VCR.use_cassette('file_not_found') do
      virustotal_report = VirustotalAPI::File.find(@sha256, @api_key)

      assert !virustotal_report.exists?
    end

    VCR.use_cassette('domain_bad_request') do
      virustotal_report = VirustotalAPI::Domain.find(@domain, @api_key)

      assert !virustotal_report.exists?
    end
  end
end
