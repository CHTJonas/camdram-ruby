require 'minitest/autorun'
require 'minitest/retry'
require 'camdram/client'

raise 'API client app id not set' if !ENV['APP_ID']
raise 'API client app secret not set' if !ENV['APP_SECRET']

# Retry failed tests (eg. due to timeouts)
Minitest::Retry.use!(
  exceptions_to_retry: [Camdram::Error::GenericException, Camdram::Error::ClientError, Camdram::Error::ServerError, Camdram::Error::Timeout],
  retry_count: 5,
  verbose: true
)

class Minitest::Test
  def setup
    @client = ::Camdram::Client.new do |config|
      config.client_credentials(ENV['APP_ID'], ENV['APP_SECRET'])
    end
  end
end
