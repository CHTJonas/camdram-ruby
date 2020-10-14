# frozen_string_literal: true

require 'multiton'
require 'oauth2'
require 'faraday/error'
require 'camdram/version'
require 'camdram/error'

module Camdram
  class HTTP
    extend Multiton
    attr_reader :mode, :access_token

    def initialize(key); end

    # Setup the API backend to use the client credentials OAuth2 strategy
    #
    # @param app_id [String] The API client application identifier.
    # @param app_secret [String] The API client application secret.
    # @param block [Proc] The Faraday connection builder.
    def client_credentials(app_id, app_secret, &block)
      opts = { site: ::Camdram.base_url,
        authorize_url: "/oauth/v2/auth",
        token_url: "/oauth/v2/token",
        connection_opts: {
          headers: {
            user_agent: "Camdram Ruby v#{Camdram.version}"
          }
        },
        max_redirects: 3
      }
      @client = ::OAuth2::Client.new(app_id, app_secret, opts, &block)
      @access_token = nil
      @mode = :client_credentials
      nil
    end

    # Setup the API backend to use the authorisation code OAuth2 strategy
    #
    # @param token_hash [Hash] A hash of the access token, refresh token and expiry Unix time.
    # @param app_id [String] The API client application identifier.
    # @param app_secret [String] The API client application secret.
    # @param block [Proc] The Faraday connection builder.
    def auth_code(token_hash, app_id, app_secret, &block)
      self.client_credentials(app_id, app_secret, &block)
      @access_token = OAuth2::AccessToken.from_hash(@client, token_hash)
      @mode = :auth_code
      nil
    end

    # Sets the user agent header sent in each HTTP request
    #
    # @param agent [String] The user agent header to send with HTTP requests.
    # @return [String] The agent string itself.
    def user_agent=(agent)
      @client.connection = nil
      @client.options[:connection_opts] = {headers: {user_agent: agent}}
      agent
    end

    # Returns the user agent HTTP header sent with each API request
    #
    # @return [String] The user agent header to send with API requests.
    def user_agent
      @client.options[:connection_opts][:headers][:user_agent]
    end

    # Sets the API URL that each HTTP request is sent to
    #
    # @param url [String] The API hostname to send requests to.
    # @return [String] The url itself.
    def base_url=(url)
      @client.site = url
    end

    # Returns the root URL that each API request is sent to
    #
    # @return [String] The hostname & protocol to send API requests to.
    def base_url
      @client.site
    end

    # Disables automatic renewal of expired API access tokens.
    def disable_auto_token_renewal
      @auto_renew_disabled = true
    end

    # Sends a HTTP-get request to the Camdram API
    #
    # @param url_slug [String] The URL slug to send the request to.
    # @return [OAuth2::Response] The OAuth2 response object from the Camdram API.
    def get(url_slug)
      raise Camdram::Error::Misconfigured.new('Camdram OAuth client not setup correctly') unless @client
      if (!@access_token && @mode == :client_credentials)
        handle_exceptions do
          @access_token = @client.client_credentials.get_token
        end
      end
      if !@auto_renew_disabled && access_token_expiring_soon?
        warn 'refreshing expired access token' unless @mode == :client_credentials
        self.refresh!
      end
      handle_exceptions do
        @access_token.get(url_slug, parse: :json)
      end
    end

    # Returns true if the access token is expiring in the next 30 seconds
    #
    # @return [Boolean]
    def access_token_expiring_soon?
      # If setup in read-only mode then just return immediately
      return false if (@access_token.token == "")
      # By default, Camdram access tokens are valid for one hour.
      # We factor in a thirty second safety margin.
      Time.now.to_i + 30 >= @access_token.expires_at if @access_token
    end

    # Refreshes the Camdram OAuth access token
    #
    # @return [OAuth2::AccessToken] The new access token.
    def refresh!
      handle_exceptions do
        if (@mode == :client_credentials)
          new_token = @client.client_credentials.get_token
          @access_token = new_token
        else
          new_token = @access_token.refresh!
          @access_token = new_token
        end
      end
    end

    def handle_exceptions
      begin
        yield
      rescue OAuth2::Error => e
        raise Camdram::Error::GenericException.new, e unless e.code.is_a? Hash
        http_status = e.code['code']
        raise Camdram::Error::GenericException.new, e unless http_status.is_a? Integer
        if http_status.between?(400, 499)
          raise Camdram::Error::ClientError.new, e
        elsif http_status.between?(500, 599)
          raise Camdram::Error::ServerError.new, e
        else
          raise Camdram::Error::GenericException.new, e
        end
      rescue Faraday::TimeoutError => e
        raise Camdram::Error::Timeout.new, e
      rescue Faraday::ConnectionFailed => e
        if e.wrapped_exception.class == Net::OpenTimeout
          raise Camdram::Error::Timeout.new, e
        else
          raise Camdram::Error::GenericException.new, e
        end
      rescue => e
        raise Camdram::Error::GenericException.new, e
      end
    end
  end
end
