# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIVTReportTest < Minitest::Test
  def test_api_base_uri
    assert VirustotalAPI::URI.is_a?(String)
    assert VirustotalAPI::URI, 'https://www.virustotal.com/vtapi/v2'
  end
end
