require 'camdram/base'
require 'camdram/api'
require 'camdram/show'
require 'camdram/organisation'

module Camdram
  class User < Base
    include API
    attr_accessor :name, :email
    attr_writer :base_url, :access_token

    # Return a hash of the user's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        name: name,
        email: email,
      }
    end

    # Return the unique Camdram URL slug of the user
    #
    # @return [String] The full URL slug.
    def url_slug
      "/auth/account.json"
    end

    # Return an array of shows the user is authorised for
    #
    # @return [Array] An array of Camdram::Show objects.
    def get_shows
      slug = "/auth/account/shows.json"
      get_array(slug, Show)
    end

    # Return an array of societies the user is authorised for
    #
    # @return [Array] An array of Camdram::Organisation objects
    def get_orgs
      slug = "/auth/account/organisations.json"
      get_array(slug, Organisation)
    end

  end
end
