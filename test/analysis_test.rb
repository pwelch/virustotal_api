# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIAnalysisTest < Minitest::Test
  def setup
    @url     = 'http://www.google.com'
    @api_key = 'theapikey'
  end

  def test_todo
    VCR.use_cassette('url_find') do
      vtreport = VirustotalAPI::URL.find(@url, @api_key)

      @id = vtreport.id
      assert @id.is_a?(String)
    end

    VCR.use_cassette('analysis') do
      analysis = VirustotalAPI::Analysis.find(@id, @api_key)

      assert analysis.exists?
      assert analysis.id.is_a?(String)
    end
  end
end
