require 'camdram/base'
require 'camdram/performance'
require 'camdram/organisation'
require 'camdram/venue'

module Camdram
  class Show < Base
    attr_accessor :name, :description, :slug, :author, :category, :performances, :society, :venue

    # Instantiate a new Show object from a JSON hash
    #
    # @note See the Base class for details
    # @param options [Hash] A single JSON hash with symbolized keys
    # @return [Show]
    def initialize(options = {})
      super(options)
      @society = Organisation.new( @society )
      @venue = Venue.new( @venue )
      @performances = split_performances( @performances )
    end

    # Return a hash of the shows's attributes
    #
    # @return [Hash]
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

    # Return the unique Camdram URL of the show
    #
    # @return [String]
    def url
      "/shows/#{slug}.json"
    end

    private

    def split_performances(json)
      performances = Array.new
      json.each do |performance|
        performances << Performance.new( performance )
      end
      return performances
    end
  end
end
