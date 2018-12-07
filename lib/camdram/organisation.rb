require 'camdram/base'
require 'camdram/api'
require 'camdram/image'
require 'camdram/news'
require 'camdram/show'
require 'camdram/diary'

module Camdram
  class Organisation < Base
    include API
    attr_accessor :name, :description, :image, :facebook_id, :twitter_id, :short_name, :slug

    # Instantiate a new Organisation object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Organisation] The new Organisation object.
    def initialize(options = {})
      super(options)
      @image = Image.new( @image ) unless @image.nil?
    end

    # Return a hash of the organisation's attributes
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
        slug: slug,
      }
    end

    # Gets an array of the organisation's news items
    #
    # @return [Array] An array of News objects.
    def news
      news_url = "#{self.class.url}/#{slug}/news.json"
      response = get(news_url)
      split_object( response, News )
    end

    # Gets an array of the organisation's upcoming shows
    #
    # @return [Array] An array of Show objects.
    def shows
      shows_url = "#{self.class.url}/#{slug}/shows.json"
      response = get(shows_url)
      split_object( response, Show )
    end

    # Gets a diary object which contains an array of upcoming calendar events for the organisation
    #
    # @return [Camdram::Diary] A Diary object.
    def diary()
      url = "#{self.class.url}/#{slug}/diary.json"
      response = get(url)
      Diary.new(response)
    end

    # Returns the URL+slug of the organisation
    #
    # @return [String] The full URL and slug.
    def url_slug
      "#{self.class.url}/#{slug}.json"
    end

    # Returns the URL stub assocaited with all organisations
    #
    # @return [String] The URL stub.
    def self.url
      '/societies'
    end
  end
end
