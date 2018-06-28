require 'camdram/api'
require 'camdram/user'
require 'camdram/version'

module Camdram
  class Client
    include API
    attr_accessor :api_token
    attr_writer :user_agent, :api_url

    # Initializes a new Client object using a block
    #
    # @return [Camdram::Client]
    def initialize
      if !block_given?
        warn 'Camdram::Client instantiated without config block'
      else
        yield(self)
      end
    end

    # Returns true if the API access token is set
    #
    # @return [Boolean]
    def api_token?
      !(blank?(api_token))
    end

    # Returns the API URL that each HTTP request is sent to
    #
    # @return [String]
    def api_url
      @api_url ||= Camdram::BASE_URL
    end

    # Returns the user agent header sent in each HTTP request
    #
    # @return [String]
    def user_agent
      @user_agent ||= "Camdram Ruby v#{Camdram::VERSION}"
    end

    def user
      raise 'API token not set' if !api_token?
      url = api_url + "/auth/account.json"
      response = get(url, @api_token, user_agent)
      user = User.new(response, user_agent)
      user.base_url = api_url
      user.access_token = @api_token
      return user
    end

  private

    # Returns true if a given string is blank
    #
    # @param string [String]
    # @return [Boolean]
    def blank?(string)
      string.respond_to?(:empty?) ? string.empty? : false
    end
  end
end
