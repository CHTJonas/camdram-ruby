require 'camdram/api'
require 'camdram/error'
require 'camdram/version'
require 'camdram/user'
require 'camdram/show'
require 'camdram/organisation'
require 'camdram/venue'
require 'camdram/person'
require 'camdram/search'

module Camdram
  class Client
    include API
    attr_reader :api_token

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

    # Sets the API access token
    #
    # @param token [String] The access token used to authenticate API calls.
    # @return [String] The token itself.
    def api_token=(token)
      @http.api_token = token if !@http.nil?
      @api_token = token
    end

    # Returns the API URL that each HTTP request is sent to
    #
    # @return [String] The API hostname to send requests to.
    def base_url
      @base_url ||= Camdram::BASE_URL
    end

    # Sets the API URL that each HTTP request is sent to
    #
    # @param url [String] The API hostname to send requests to.
    # @return [String] The url itself.
    def base_url=(url)
      @http.base_url = url if !@http.nil?
      @base_url = url
    end

    # Returns the user agent header sent in each HTTP request
    #
    # @return [String] The user agent header to send with HTTP requests.
    def user_agent
      @user_agent ||= "Camdram Ruby v#{Camdram::VERSION}"
    end

    # Sets the user agent header sent in each HTTP request
    #
    # @param agent [String] The user agent header to send with HTTP requests.
    # @return [String] The agent string itself.
    def user_agent=(agent)
      @http.user_agent = agent if !@http.nil?
      @user_agent = agent
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

    # Lookup a show by its ID or slug
    #
    # @param id [Integer] The numeric ID of the show.
    # @param id [String] The slug of the show.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Show] The show with the provided ID or slug.
    def get_show(id)
      http_construct(false)
      url = nil
      if id.is_a? Integer
        url = "#{Show.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Show.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      return Show.new(response, @http)
    end

    # Lookup an organisation by its ID or slug
    #
    # @param id [Integer] The numeric ID of the organisation.
    # @param id [String] The slug of the organisation.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Organisation] The organisation with the provided ID or slug.
    def get_org(id)
      http_construct(false)
      url = nil
      if id.is_a? Integer
        url = "#{Organisation.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Organisation.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      Organisation.new(response, @http)
    end

    # Lookup a venue by its ID or slug
    #
    # @param id [Integer] The numeric ID of the venue.
    # @param id [String] The slug of the venue.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Venue] The venue with the provided ID or slug.
    def get_venue(id)
      http_construct(false)
      url = nil
      if id.is_a? Integer
        url = "#{Venue.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Venue.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      Venue.new(response, @http)
    end

    # Lookup a person by their ID or slug
    #
    # @param id [Integer] The numeric ID of the person.
    # @param id [String] The person's slug.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Show] The person  with the provided ID or slug.
    def get_person(id)
      http_construct(false)
      url = nil
      if id.is_a? Integer
        url = "#{Person.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Person.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      Person.new(response, @http)
    end

    # Return an array of search entity results based on a search string
    #
    # @param query [String] The query string to search with.
    # @return [Array] An array of Search objects.
    def search(query)
      http_construct(false)
      url = "/search.json?q=#{query}"
      response = get(url)
      split_object( response, Search )
    end

  private

    # Construct a class to handle HTTP requests if necessary
    #
    # @raise [StandardError] Error raised when the API token is not set.
    def http_construct(check_for_token = true)
      if !check_for_token || api_token?
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
