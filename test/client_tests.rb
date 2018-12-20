require 'test_helper'

class ClientTests < Minitest::Test
  def test_client
    assert_equal "https://www.camdram.net", @client.base_url
    assert_equal "Camdram Ruby v#{@client.version}", @client.user_agent
  end
end
