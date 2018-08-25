require 'camdram/base'
require 'camdram/api'
require 'camdram/news'
require 'camdram/show'

module Camdram
  class Venue < Base
    include API
    attr_accessor :name, :description, :facebook_id, :twitter_id, :short_name, :college, :slug, :address, :latitude, :longitude

    # Return a hash of the venue's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        name: name,
        description: description,
        facebook_id: facebook_id,
        twitter_id: twitter_id,
        short_name: short_name,
        college: college,
        slug: slug,
        address: address,
        latitude: latitude,
        longitude: longitude,
      }
    end

    # Gets an array of the venue's news items
    #
    # @return [Array] An array of News objects.
    def news
      news_url = "#{self.class.url}/#{slug}/news.json"
      response = get(news_url)
      split_object( response, News )
    end

    # Gets an array of the venue's upcoming shows
    #
    # @return [Array] An array of Show objects.
    def shows
      shows_url = "#{self.class.url}/#{slug}/shows.json"
      response = get(shows_url)
      split_object( response, Show )
    end

    # Returns the URL+slug of the venue
    #
    # @return [String] The full URL and slug.
    def url_slug
      "#{self.class.url}/#{slug}.json"
    end

    # Returns the URL stub assocaited with all venues
    #
    # @return [String] The URL stub.
    def self.url
      '/venues'
    end
  end
end
