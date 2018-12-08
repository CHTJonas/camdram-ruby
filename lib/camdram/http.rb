require 'singleton'
require 'oauth2'
require 'camdram/version'
require 'camdram/error'

module Camdram
  class HTTP
    include Singleton

    # Setup the API backend to use the client credentials OAuth2 strategy
    #
    # @param app_id [String] The API client application identifier.
    # @param app_secret [String] The API client application secret.
    def client_credentials(app_id, app_secret)
      @client = OAuth2::Client.new(app_id, app_secret,
                                  site: Camdram::BASE_URL,
                                  authorize_url: "/oauth/v2/auth",
                                  token_url: "/oauth/v2/token",
                                  connection_opts: {headers: {user_agent: "Camdram Ruby v#{Camdram::VERSION}"}},
                                  max_redirects: 3
                                )
      return nil
    end

    # Setup the API backend to use the authorisation code OAuth2 strategy
    #
    # @param token_hash [Hash] A hash of the access token, refresh token and expiry Unix time
    # @param app_id [String] The API client application identifier.
    # @param app_secret [String] The API client application secret
    def auth_code(token_hash, app_id, app_secret)
      self.client_credentials(app_id, app_secret)
      @access_token = OAuth2::AccessToken.from_hash(@client, token_hash)
      return nil
    end

    # Sets the user agent header sent in each HTTP request
    #
    # @param agent [String] The user agent header to send with HTTP requests.
    # @return [String] The agent string itself.
    def user_agent=(agent)
      @client.connection = nil
      @client.options[:connection_opts] = {headers: {user_agent: agent}}
    end

    # Sets the API URL that each HTTP request is sent to
    #
    # @param url [String] The API hostname to send requests to.
    # @return [String] The url itself.
    def base_url=(url)
      @client.site=url
    end

    # Sends a HTTP-get request to the Camdram API
    #
    # @param url_slug [String] The URL slug to send the request to.
    # @param max_redirects [Integer] The maximum number of redirects.
    # @raise [Camdram::Error::RedirectError] Error raised when too many redirects occur.
    # @return [String]
    def get(url_slug)
      raise('OAuth not setup correctly') if @client.nil?
      @access_token ||= @client.client_credentials.get_token
      if access_token_expiring_soon?
        warn 'refreshing expired access token'
        new_token = @access_token.refresh!
        @access_token = new_token
      end
      @access_token.get(url_slug, parse: :json)
    end

    private

    def access_token_expiring_soon?
      # If setup in read-only mode then just return immediately
      return false if (@access_token.token == "")
      # By default, Camdram access tokens are valid for one hour.
      # We factor in a thirty second safety margin.
      Time.now.to_i + 30 >= @access_token.expires_at if @access_token
    end
  end
end
