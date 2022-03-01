require 'test_helper'

class ErrorTests < Minitest::Test
  def setup; end

  def self.client(socket_timeout, request_timeout)
    Camdram::Client.new do |config|
      config.client_credentials(ENV['APP_ID'], ENV['APP_SECRET']) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  :net_http do |http|
          http.open_timeout = socket_timeout
          http.read_timeout = request_timeout
        end
      end
    end
  end

  def test_open_timeout
    result = false
    client = ErrorTests.client(1/1000, 1)
    begin
      client.user
    rescue Camdram::Error::Timeout => e
      assert_equal Net::OpenTimeout, e.cause.cause.cause.class
      result = true
    end
    assert result
  end

  def test_read_timeout
    result = false
    client = ErrorTests.client(1, 1/1000)
    begin
      client.user
    rescue Camdram::Error::Timeout => e
      assert_equal Net::ReadTimeout, e.cause.cause.class
      result = true
    end
    assert result
  end
end
