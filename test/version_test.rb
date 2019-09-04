# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIVTReportTest < Minitest::Test
  def test_version
    assert VirustotalAPI::VERSION.is_a?(String)
  end
end
