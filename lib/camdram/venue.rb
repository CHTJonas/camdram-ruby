require 'camdram/base'

module Camdram
  class Venue < Base
    attr_accessor :name, :description, :facebook_id, :twitter_id, :short_name, :slug, :address, :latitude, :longitude, :type

    # Return a hash of the venue's attributes
    #
    # @return [Hash]
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

    # Return the unique Camdram URL of the venue
    #
    # @return [String]
    def url
      "/venues/#{slug}.json"
    end
  end
end
