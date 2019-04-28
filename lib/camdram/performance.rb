require 'date'
require 'camdram/base'
require 'camdram/venue'

module Camdram
  class Performance < Base
    attr_accessor :start_at, :repeat_until, :venue, :other_venue

    # Instantiate a new Performance object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Performance] The new Performance object.
    def initialize(*args)
      super(*args)
      @start_at = DateTime.parse(@start_at) unless @start_at.nil?
      @repeat_until = Date.parse(@repeat_until) unless @repeat_until.nil?
      @venue = Venue.new(@venue, @client_instance) unless @venue.nil?
    end

    # Return a hash of the performance's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        start_at: start_at,
        repeat_until: repeat_until,
        venue: venue,
        other_venue: other_venue,
      }
    end
  end
end
