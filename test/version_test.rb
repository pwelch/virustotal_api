# encoding: utf-8
require './test/test_helper'

class VirustotalAPIVTReportTest < Minitest::Test
  def test_version
    assert VirustotalAPI::VERSION.is_a?(String)
    assert VirustotalAPI::VERSION, '0.1.0'
  end
end
