# frozen_string_literal: true

require './test/test_helper'

class VirustotalAPIGroupReportTest < Minitest::Test
  def setup
    @group_id = 'GROUP_us'
    @api_key  = 'testapikey'
  end

  def test_class_exists
    assert VirustotalAPI::Group
  end

  def test_report_response
    VCR.use_cassette('group_find') do
      vtgroup_report = VirustotalAPI::Group.find(@group_id, @api_key)

      # Make sure that the JSON was parsed
      assert vtgroup_report.is_a?(VirustotalAPI::Group)
      assert vtgroup_report.report.is_a?(Hash)
    end
  end

  def test_find
    VCR.use_cassette('group_find') do
      vtgroup_report = VirustotalAPI::Group.find(@group_id, @api_key)

      assert vtgroup_report.report_url.is_a?(String)
    end
  end
end
