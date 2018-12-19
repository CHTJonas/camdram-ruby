require 'camdram/api'
require 'camdram/error'
require 'camdram/version'
require 'camdram/user'
require 'camdram/show'
require 'camdram/society'
require 'camdram/venue'
require 'camdram/person'
require 'camdram/role'
require 'camdram/search'
require 'camdram/diary'
require 'camdram/application'
require 'camdram/audition'
require 'camdram/techie_advert'

module Camdram
  class Client
    include API

    # Initializes a new Client object using a block
    #
    # @return [Camdram::Client] The top-level Camdram client.
    def initialize
      @instance_key = self.object_id
      raise Camdram::Error::NotConfigured.new('Camdram::Client instantiated without config block') unless block_given?
      yield(self)
      raise Camdram::Error::MisConfigured.new('Camdram::Client instantiated with an invalid config block') unless HTTP.instance(@instance_key).mode
    end

    # Setup the API backend to use the client credentials OAuth2 strategy
    #
    # @param app_id [String] The API client application identifier.
    # @param app_secret [String] The API client application secret.
    def client_credentials(app_id, app_secret)
      HTTP.instance(@instance_key).client_credentials(app_id, app_secret)
    end

    # Setup the API backend to use the authorisation code OAuth2 strategy
    #
    # @param token_hash [Hash] A hash of the access token, refresh token and expiry Unix time
    # @param app_id [String] The API client application identifier.
    # @param app_secret [String] The API client application secret.
    def auth_code(token_hash, app_id, app_secret)
      HTTP.instance(@instance_key).auth_code(token_hash, app_id, app_secret)
    end

    # Setup the API backend in read-only mode
    # @note It is highly recommended that applications authenticate when making Camdram API calls.
    def read_only
      HTTP.instance(@instance_key).auth_code({access_token: nil}, nil, nil)
    end
    end

    # Sets the user agent header sent in each HTTP request
    #
    # @param agent [String] The user agent header to send with HTTP requests.
    # @return [String] The agent string itself.
    def user_agent=(agent)
      HTTP.instance(@instance_key).user_agent = agent
    end

    # Returns the user agent HTTP header sent with each API request
    #
    # @return [String] The user agent header to send with API requests.
    def user_agent
      HTTP.instance(@instance_key).user_agent
    end

    # Sets the API URL that each HTTP request is sent to
    #
    # @param url [String] The API hostname to send requests to.
    # @return [String] The url itself.
    def base_url=(url)
      HTTP.instance(@instance_key).base_url = url
    end

    # Returns the root URL that each API request is sent to
    #
    # @return [String] The hostname & protocol to send API requests to.
    def base_url
      HTTP.instance(@instance_key).base_url
    end

    # Returns the user associated with the API token if set, otherwise raises an exception
    #
    # @raise [StandardError] Error raised when the API token is not set.
    # @return [Camdram::User] The associated User object.
    def user
      slug = "/auth/account.json"
      response = get(slug)
      User.new(response, @instance_key)
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
      return Show.new(response, @instance_key)
    end

    # Lookup a society by its ID or slug
    #
    # @param id [Integer] The numeric ID of the society.
    # @param id [String] The slug of the society.
    # @raise [ArgumentError] Error raised when an integer or string is not provided.
    # @return [Camdram::Society] The society with the provided ID or slug.
    def get_society(id)
      url = nil
      if id.is_a? Integer
        url = "#{Society.url}/by-id/#{id}.json"
      elsif id.is_a? String
        url = "#{Society.url}/#{id}.json"
      else
        raise ArgumentError.new 'id must be an integer, or slug must be a string'
      end
      response = get(url)
      Society.new(response, @instance_key)
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
      Venue.new(response, @instance_key)
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
      Person.new(response, @instance_key)
    end

    # Returns an array of all registered societies
    #
    # @return [Array] An array of Society objects.
    def get_societies
      url = "#{Society.url}.json"
      response = get(url)
      split_object( response, Society )
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
      split_object( response, Person )
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
      Diary.new(response, @instance_key)
    end

    # Gets a diary object which contains an array of events occuring in the given year/term
    #
    # @return [Camdram::Diary] A Diary object.
    def termly_diary(year, term=nil)
      url = "/diary/#{year}"
      url << "/#{term}" if term
      url << ".json"
      response = get(url)
      Diary.new(response, @instance_key)
    end

    # Gets an array of actor auditions listed on Camdram
    #
    # @return [Array] An array of Audition objects.
    def auditions
      url = '/vacancies/auditions.json'
      response = get(url)
      split_object( response, Audition )
    end

    # Gets an array of technical & designer roles advertised on Camdram
    #
    # @return [Array] An array of TechieAdvert objects.
    def techie_adverts
      url = '/vacancies/techies.json'
      response = get(url)
      split_object( response, TechieAdvert )
    end

    # Gets an array of producer/director roles and show applications advertised on Camdram
    #
    # @return [Array] An array of Application objects.
    def applications
      url = '/vacancies/applications.json'
      response = get(url)
      split_object( response, Application )
    end
  end
end
