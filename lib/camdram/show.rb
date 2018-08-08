require 'camdram/base'
require 'camdram/api'
require 'camdram/organisation'
require 'camdram/venue'
require 'camdram/performance'
require 'camdram/image'

module Camdram
  class Show < Base
    include API
    attr_accessor :name, :description, :slug, :author, :category, :performances, :society, :other_society, :venue, :other_venue, :image

    # Instantiate a new Show object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Show] The new Show object.
    def initialize(options = {}, http = nil)
      super(options, http)
      @society = Organisation.new( @society, @http )
      @venue = Venue.new( @venue, @http )
      @performances = split_object( @performances, Performance )
      @image = Image.new( @image, @http )
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

    # Return the unique Camdram URL slug of the show
    #
    # @return [String] The full URL slug.
    def url_slug
      "/shows/#{slug}.json"
    end

  end
end
