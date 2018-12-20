require 'camdram/base'
require 'camdram/api'
require 'camdram/refreshable'
require 'camdram/image'
require 'camdram/news'
require 'camdram/show'
require 'camdram/diary'

module Camdram
  class Society < Base
    include API, Refreshable
    attr_accessor :name, :description, :image, :facebook_id, :twitter_id, :short_name, :slug

    # Instantiate a new Society object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Society] The new Society object.
    def initialize(*args)
      super(*args)
      @image = Image.new(@image, @client_instance) unless @image.nil?
    end

    # Return a hash of the society's attributes
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

    # Gets an array of the society's news items
    #
    # @return [Array] An array of News objects.
    def news
      url = "#{self.class.url}/#{slug}/news.json"
      response = get(url)
      split_object(response, News)
    end

    # Gets an array of the society's upcoming shows
    #
    # @return [Array] An array of Show objects.
    def shows(from = nil, to = nil)
      url = "#{self.class.url}/#{slug}/shows.json"
      url << "?" if from || to
      url << "from=#{from}" if from
      url << "&" if from && to
      url << "to=#{to}" if to
      response = get(url)
      split_object(response, Show)
    end

    # Gets a diary object which contains an array of upcoming calendar events for the society
    #
    # @return [Camdram::Diary] A Diary object.
    def diary(from = nil, to = nil)
      url = "#{self.class.url}/#{slug}/diary.json"
      url << "?" if from || to
      url << "from=#{from}" if from
      url << "&" if from && to
      url << "to=#{to}" if to
      response = get(url)
      Diary.new(response, @client_instance)
    end

    # Returns the URL+slug of the society
    #
    # @return [String] The full URL and slug.
    def url_slug
      "#{self.class.url}/#{slug}.json"
    end

    # Returns the URL stub assocaited with all societies
    #
    # @return [String] The URL stub.
    def self.url
      '/societies'
    end
  end
end
