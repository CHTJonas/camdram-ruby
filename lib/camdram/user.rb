require 'camdram/base'
require 'camdram/show'
require 'camdram/organisation'
require 'camdram/api'

module Camdram
  class User < Base
    include API
    attr_accessor :name, :email
    attr_writer :base_url, :access_token

    # Instantiate a new User object
    #
    # @param options [Hash] A single JSON hash with symbolized keys
    # @return [Base]
    def initialize(options = {}, user_agent)
      super(options)
      @user_agent = user_agent
    end

    # Return a hash of the user's attributes
    #
    # @return [Hash]
    def info
      {
        id: id,
        name: name,
        email: email,
      }
    end

    # Return the unique Camdram URL of the user
    #
    # @return [String]
    def url
      @base_url + "/auth/account.json"
    end

    # Return an array of shows the user is authorised for
    #
    # @return [Array] An array of Show objects
    def get_shows
      url = @base_url + "/auth/account/shows.json"
      get_array(url, @access_token, Show, @user_agent)
    end

    # Return an array of societies the user is authorised for
    #
    # @return [Array] An array of Organisation objects
    def get_orgs
      url = @base_url + "/auth/account/organisations.json"
      get_array(url, @access_token, Organisation, @user_agent)
    end

  end
end
