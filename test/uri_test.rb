# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIVTReportTest < Minitest::Test
  def test_api_base_uri
    assert VirustotalAPI::URI.is_a?(String)
    assert_equal 'https://www.virustotal.com/api/v3', VirustotalAPI::URI
  end
end
