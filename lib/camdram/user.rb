require 'camdram/base'
require 'camdram/api'
require 'camdram/show'
require 'camdram/organisation'

module Camdram
  class User < Base
    include API
    attr_accessor :name, :email

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
    # @return [Array] An array of Camdram::Organisation objects.
    def get_orgs
      orgs_share('society')
    end

    # Return an array of venues the user is authorised for
    #
    # @return [Array] An array of Camdram::Venue objects.
    def get_venues
      orgs_share('venue')
    end

    private

    # Shared code because Camdram stores venues and societies together in the same table
    #
    # @param orm_type [String] The ORM type to match against (either "society" or "venue").
    # @return [Array] An array of objects of the specified ORM type's class.
    def orgs_share(orm_type)
      object = case orm_type
        when 'society' then Organisation
        when 'venue' then Venue
      end
      slug = "/auth/account/organisations.json"
      json = get(slug)
      objects = Array.new
      json.each do |obj|
        objects << object.new( obj ) if obj[:_type] == orm_type
      end
      return objects
    end

  end
end
