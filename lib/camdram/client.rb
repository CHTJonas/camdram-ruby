require 'camdram/api'
require 'camdram/error'
require 'camdram/version'
require 'camdram/user'
require 'camdram/show'
require 'camdram/organisation'
require 'camdram/venue'
require 'camdram/person'

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
        warn 'Camdram::Client instantiated without config block - did you mean to add an API key?'
      else
        yield(self)
      end
    end

    # Returns true if the API access token is set
    #
    # @return [Boolean] Whether the API token is set or not.
    def api_token?
      !@api_token.nil? && !(blank?(@api_token))
    end
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
      http_construct
      slug = "/auth/account.json"
      response = get(slug)
      User.new(response, @http)
    end

    # Lookup a show by its unique Camdram ID
    #
    # @param id [Integer] The numeric Camdram ID of the show.
    # @return [Show] The Show with the provided ID.
    def get_show(id)
      http_construct
      url = "/shows/by-id/#{id}.json"
      response = get(url)
      Show.new(response, @http)
    end

    # Lookup an organisation by its unique Camdram ID
    #
    # @param id [Integer] The numeric Camdram ID of the organisation.
    # @return [Organisation] The Ogranisation with the provided ID.
    def get_org(id)
      http_construct
      url = "/societies/by-id/#{id}.json"
      response = get(url)
      Organisation.new(response, @http)
    end

    # Lookup a venue by its unique Camdram ID
    #
    # @param id [Integer] The numeric Camdram ID of the venue.
    # @return [Venue] The Venue with the provided ID.
    def get_venue(id)
      http_construct
      url = "/venues/by-id/#{id}.json"
      response = get(url)
      Venue.new(response, @http)
    end

    # Lookup a person by their unique Camdram ID
    #
    # @param id [Integer] The numeric Camdram ID of the person.
    # @return [Person] The Person with the provided ID.
    def get_person(id)
      http_construct
      url = "/people/by-id/#{id}.json"
      response = get(url)
      Person.new(response, @http)
    end

  private

    # Construct a class to handle HTTP requests if necessary
    #
    # @raise [StandardError] Error raised when the API token is not set.
    def http_construct
      if api_token?
        # Create a new HTTP object if one doesn't already exist
        @http ||= HTTP.new(@api_token, base_url, user_agent)
      else
        raise Camdram::Error::NoApiKey.new 'api_token is not set'
      end
    end

    # Returns true if a given string is blank
    #
    # @param string [String] The string to test.
    # @return [Boolean] True if blank, false otherwise.
    def blank?(string)
      string.respond_to?(:empty?) ? string.empty? : false
    end
  end
end
