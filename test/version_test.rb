require './test/test_helper'

class VirustotalAPIVTReportTest < Minitest::Test
  def test_version
    assert VirustotalAPI::VERSION.kind_of?(String)
    assert VirustotalAPI::VERSION, "0.1.0"
  end
end
