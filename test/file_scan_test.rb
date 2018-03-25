require './test/test_helper'

class VirustotalAPIFileScanTest < Minitest::Test
  def setup
    @file_path = File.expand_path('test/fixtures/null_file')
    @api_key   = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::FileScan
  end

  def test_response
    VCR.use_cassette('scan') do
      virustotal_scan = VirustotalAPI::FileScan.scan(@file_path, @api_key)

      assert virustotal_scan.response.is_a?(Hash)
    end
  end

  def test_scan_id
    VCR.use_cassette('scan') do
      virustotal_scan = VirustotalAPI::FileScan.scan(@file_path, @api_key)

      assert virustotal_scan.scan_id.is_a?(String)
    end
  end
end
