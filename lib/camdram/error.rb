module Camdram
  module Error
    # Error class raised when an API call is attempted but no API key is set
    class NotConfigured < RuntimeError; end

    # Error class raised when an API call is attempted but no API key is set
    class NoApiKey < RuntimeError; end

    # Error class raised when a 'refresh access token' API call fails
    class AccessTokenRefreshFailure < RuntimeError; end
  end
end
