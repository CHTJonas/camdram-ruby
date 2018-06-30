require 'camdram/api'
require 'camdram/user'
require 'camdram/version'

module Camdram
  class Client
    include API
    attr_accessor :api_token
    attr_writer :user_agent, :base_url

    # Initializes a new Client object using a block
    #
    # @return [Camdram::Client] The top-level Camdram client.
    def initialize
      if !block_given?
        warn 'Camdram::Client instantiated without config block'
      else
        yield(self)
      end
    end

    # Returns true if the API access token is set
    #
    # @return [Boolean] Whether the API token is set or not.
    def api_token?
      !(blank?(api_token))
    end

    # Returns the API URL that each HTTP request is sent to
    #
    # @return [String] The API hostname to send requests to.
    def base_url
      @base_url ||= Camdram::BASE_URL
    end

    # Returns the user agent header sent in each HTTP request
    #
    # @return [String] The user agent header to send with HTTP requests.
    def user_agent
      @user_agent ||= "Camdram Ruby v#{Camdram::VERSION}"
    end

    # Returns the user associated with the API token if set, otherwise raises an exception
    #
    # @raise [StandardError] Error raised when the API token is not set.
    # @return [Camdram::User] The associated User object.
    def user
      raise 'API token not set' if !api_token?
      # Create a new HTTP object if one doesn't already exist
      @http ||= HTTP.new(@api_token, base_url, user_agent)
      slug = "/auth/account.json"
      response = get(slug)
      User.new(response, @http)
    end

  private

    # Returns true if a given string is blank
    #
    # @param string [String] The string to test.
    # @return [Boolean] True if blank, false otherwise.
    def blank?(string)
      string.respond_to?(:empty?) ? string.empty? : false
    end
  end
end
