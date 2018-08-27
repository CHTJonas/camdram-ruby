require 'minitest/autorun'
require 'camdram/client'

raise "API test key is not set!" if !ENV["API_test_key"]

class MiniTest::Unit::TestCase
  def setup
    @client = Camdram::Client.new do |config|
      config.api_token = ENV["API_test_key"]
    end
  end
end
