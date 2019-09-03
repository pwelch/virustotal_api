# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIURLScanTest < Minitest::Test
  def setup
    @url     = 'http://www.google.com'
    @api_key = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::URLScan
  end

  def test_scan_response
    VCR.use_cassette('url_scan') do
      vturl_scan = VirustotalAPI::URLScan.scan(@url, @api_key)

      assert vturl_scan.report.is_a?(Hash)
    end
  end

  def test_scan_url
    VCR.use_cassette('url_scan') do
      vturl_scan = VirustotalAPI::URLScan.scan(@url, @api_key)

      assert vturl_scan.scan_id.is_a?(String)
    end
  end
end
