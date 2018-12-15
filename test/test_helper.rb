require 'minitest/autorun'
require 'camdram/client'

raise 'API client app id not set' if !ENV['APP_ID']
raise 'API client app secret not set' if !ENV['APP_SECRET']

class Minitest::Test
  def setup
    @client = Camdram::Client.new do |config|
      config.client_credentials(ENV['APP_ID'], ENV['APP_SECRET'])
    end
  end
end
