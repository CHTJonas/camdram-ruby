require 'camdram/base'
require 'camdram/api'
require 'camdram/organisation'
require 'camdram/venue'
require 'camdram/performance'
require 'camdram/image'

module Camdram
  class Show < Base
    include API
    attr_accessor :name, :description, :image, :slug, :author, :prices, :other_venue, :other_society, :category, :performances, :online_booking_url, :society, :venue

    # Instantiate a new Show object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Show] The new Show object.
    def initialize(options = {}, http = nil)
      super(options, http)
      @society = Organisation.new( @society, @http ) if !@society.nil?
      @venue = Venue.new( @venue, @http ) if !@venue.nil?
      @performances = split_object( @performances, Performance )
      @image = Image.new( @image, @http ) if !@image.nil?
    end

    # Return a hash of the shows's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        name: name,
        description: description,
        slug: slug,
        author: author,
        category: category,
        performances: performances,
        society: society,
        venue: venue,
      }
    end

    # Returns the URL+slug of the show
    #
    # @return [String] The full URL and slug.
    def url_slug
      "#{self.class.url}/#{slug}.json"
    end

    # Returns the URL stub assocaited with all shows
    #
    # @return [String] The URL stub.
    def self.url
      '/shows'
    end
  end
end
