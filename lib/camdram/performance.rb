require 'camdram/base'
require 'camdram/api'
require 'camdram/venue'

module Camdram
  class Performance < Base
    include API
    attr_accessor :start_date, :end_date, :time, :venue, :other_venue

    # Instantiate a new Performance object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Performance] The new Performance object.
    def initialize(options = {}, http = nil)
      super(options, http)
      @venue = Venue.new( @venue, @http ) if !@venue.nil?
    end

    # Return a hash of the performance's attributes
    #
    # @return [Hash] Hash with symbolized keys
    def info
      {
        start_date: start_date,
        end_date: end_date,
        time: time,
        other_venue: other_venue,
      }
    end
  end
end
