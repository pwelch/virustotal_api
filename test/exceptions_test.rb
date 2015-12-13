# encoding: utf-8
require './test/test_helper'

class RateLimitErrorTest < Minitest::Test
  def test_class_exists
    assert VirustotalAPI::RateLimitError
  end
end
