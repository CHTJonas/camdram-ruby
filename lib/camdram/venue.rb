require 'camdram/base'

module Camdram
  class Venue < Base
    attr_accessor :name, :description, :facebook_id, :twitter_id, :short_name, :slug, :address, :latitude, :longitude, :type

    # Return a hash of the venue's attributes
    #
    # @return [Hash] Hash with symbolized keys
    def info
      {
        id: id,
        name: name,
        description: description,
        facebook_id: facebook_id,
        twitter_id: twitter_id,
        short_name: short_name,
        slug: slug,
        address: address,
        latitude: latitude,
        longitude: longitude,
        type: type,
      }
    end

    # Return the unique Camdram URL slug of the venue
    #
    # @return [String] The full URL slug
    def url_slug
      "/venues/#{slug}.json"
    end
  end
end
