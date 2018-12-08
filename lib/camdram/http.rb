require 'singleton'
require 'oauth2'
require 'camdram/error'
require 'camdram/version'

module Camdram
  class HTTP
    include Singleton
    attr_writer :client, :access_token

    # Sends a HTTP-get request to the Camdram API
    #
    # @param url_slug [String] The URL slug to send the request to.
    # @param max_redirects [Integer] The maximum number of redirects.
    # @raise [Camdram::Error::RedirectError] Error raised when too many redirects occur.
    # @return [String]
    def get(url_slug)
      raise('OAuth not setup correctly') if @client.nil?
      @access_token ||= @client.client_credentials.get_token
      @access_token.refresh! if @access_token.expired?
      @access_token.get(url_slug, parse: :text).body
    end

  end
end
