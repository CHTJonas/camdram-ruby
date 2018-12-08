require 'camdram/api'
require 'camdram/error'
require 'camdram/version'
require 'camdram/user'
require 'camdram/show'
require 'camdram/organisation'
require 'camdram/venue'
require 'camdram/person'
require 'camdram/role'
require 'camdram/search'
require 'camdram/diary'

module Camdram
  class Client
    include API

    # Initializes a new Client object using a block
    #
    # @return [Camdram::Client] The top-level Camdram client.
    def initialize
      raise('Camdram::Client instantiated without config block') unless block_given?
      yield(self)
    end

    # Setup the API backend to use the client credentials OAuth2 strategy
    #
    # @param app_id [String] The API client application identifier.
    # @param app_secret [String] The API client application secret.
    def client_credentials(app_id, app_secret)
      HTTP.instance.client_credentials(app_id, app_secret)
    end

    # Setup the API backend to use the authorisation code OAuth2 strategy
    #
    # @param token_hash [Hash] A hash of the access token, refresh token and expiry Unix time
    # @param app_id [String] The API client application identifier.
    # @param app_secret [String] The API client application secret
    def auth_code(token_hash, app_id, app_secret)
      HTTP.instance.auth_code(token_hash, app_id, app_secret)
    end

    # Sets the user agent header sent in each HTTP request
    #
    # @param agent [String] The user agent header to send with HTTP requests.
    # @return [String] The agent string itself.
    def user_agent=(agent)
      HTTP.instance.user_agent = agent
    end

    # Sets the API URL that each HTTP request is sent to
    #
    # @param url [String] The API hostname to send requests to.
    # @return [String] The url itself.
    def base_url=(url)
      HTTP.instance.base_url = url
    end

    # Returns the user associated with the API token if set, otherwise raises an exception
    #
    # @raise [StandardError] Error raised when the API token is not set.
    # @return [Camdram::User] The associated User object.
    def user
      slug = "/auth/account.json"
      response = get(slug)
      User.new(response)
    end

    # Returns the program version that is currently running
    #
    # @return [String] The version of camdram-ruby that is currently running.
    def version
      Camdram::VERSION
    end

    # Lookup a show by its ID or slug
    #
    # @param id [Integer] The numeric ID of the show.
    # @param id [String] The slug of the show.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Camdram::Show] The show with the provided ID or slug.
    def get_show(id)
      url = nil
      if id.is_a? Integer
        url = "#{Show.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Show.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      return Show.new(response)
    end

    # Lookup an organisation by its ID or slug
    #
    # @param id [Integer] The numeric ID of the organisation.
    # @param id [String] The slug of the organisation.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Camdram::Organisation] The organisation with the provided ID or slug.
    def get_org(id)
      url = nil
      if id.is_a? Integer
        url = "#{Organisation.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Organisation.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      Organisation.new(response)
    end

    # Lookup a venue by its ID or slug
    #
    # @param id [Integer] The numeric ID of the venue.
    # @param id [String] The slug of the venue.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Camdram::Venue] The venue with the provided ID or slug.
    def get_venue(id)
      url = nil
      if id.is_a? Integer
        url = "#{Venue.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Venue.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      Venue.new(response)
    end

    # Lookup a person by their ID or slug
    #
    # @param id [Integer] The numeric ID of the person.
    # @param id [String] The person's slug.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Camdram::Person] The person  with the provided ID or slug.
    def get_person(id)
      url = nil
      if id.is_a? Integer
        url = "#{Person.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Person.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      Person.new(response)
    end

    # Returns an array of all registered organisations
    #
    # @return [Array] An array of Organisation objects.
    def get_orgs
      url = "#{Organisation.url}.json"
      response = get(url)
      split_object( response, Organisation )
    end

    # Returns an array of all registered venues
    #
    # @return [Array] An array of Venue objects.
    def get_venues
      url = "#{Venue.url}.json"
      response = get(url)
      split_object( response, Venue )
    end

    # Returns an array containing a sample of people taking part in shows this week
    #
    # @return [Array] An array of Role objects.
    def get_people
      url = "#{Person.url}.json"
      response = get(url)
      split_object( response, Role )
    end

    # Return an array of search entity results based on a search string
    #
    # @param query [String] The query string to search with.
    # @return [Array] An array of Search objects.
    def search(query, limit=10, page=1)
      url = "/search.json?q=#{query}&limit=#{limit}&page=#{page}"
      response = get(url)
      split_object( response, Search )
    end

    # Gets a diary object which contains an array of upcoming calendar events
    #
    # @return [Camdram::Diary] A Diary object.
    def diary(start_date=nil, end_date=nil)
      url = "/diary.json"
      if start_date && end_date
        url = "/diary/#{start_date}.json?end=#{end_date}"
      end
      response = get(url)
      Diary.new(response)
    end

    # Gets a diary object which contains an array of events occuring in the given year/term
    #
    # @return [Camdram::Diary] A Diary object.
    def termly_diary(year, term=nil)
      url = "/diary/#{year}"
      url << "/#{term}" if term
      url << ".json"
      response = get(url)
      Diary.new(response)
    end
  end
end
