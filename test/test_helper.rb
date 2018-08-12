require 'minitest/autorun'
require 'camdram/client'

class MiniTest::Unit::TestCase
  def setup
    @client = Camdram::Client.new do |config|
      config.api_token = ENV["API_test_key"]
    end
  end
end
