require 'json'

module Camdram
  module Error

    # Error class raised when an API call is attempted but no API key is set
    class NoApiKey < RuntimeError; end

    # Error class for Camdram API calls
    class CamdramError < StandardError
      attr_reader :http_status_code, :http_headers, :response_body
      attr_reader :error, :error_description

      def initialize(code, body, headers)
        @http_status_code = code
        @response_body = body
        @http_headers = headers

        # Camdram doesn't always return errors in JSON format
        # and when it does, the format is sometimes inconsistent
        begin
          error_hash = JSON.parse(@response_body)
          @error = error_hash['error']
          @error_description = error_hash['error_description']
        rescue JSON::ParserError => e
          # FIXME come up with a better solution for this
          @error = http_status_code
          @error_description = response_body
        end
        message = "#{error}: #{error_description}"
        super(message)
        raise self
      end
    end

    # 3xx level errors
    class RedirectError < CamdramError; end
    # 4xx level errors
    class ClientError < CamdramError; end
    # 5xx level errors
    class ServerError < CamdramError; end
    # 400
    class BadRequest < ClientError; end
    # 403
    class Forbidden < ClientError; end
    # 404
    class NotFound < ClientError; end
    # 401
    class Unauthorized < ClientError; end
    # 429
    class RateLimit < ClientError; end

    # This is called by the HTTP class when a request
    # is not successful and is not a redirect
    def self.for(response)
      code = response.code.to_i
      error_class = case code
                    when 300..399
                      RedirectError
                    when 400
                      BadRequest
                    when 403
                      Forbidden
                    when 404
                      NotFound
                    when 401
                      Unauthorized
                    when 429
                      RateLimit
                    when 400..499
                      ClientError
                    else
                      CamdramError
                    end
      error_class.new(code, response.body, response.header)
    end
  end
end
