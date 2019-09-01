require 'test_helper'

class ClientTests < Minitest::Test
  def test_client
    assert_equal Camdram.base_url, @client.base_url
    assert_equal "Camdram Ruby v#{Camdram::Version.to_s}", @client.user_agent
  end
end
