require 'camdram/base'
require 'camdram/api'
require 'camdram/show'
require 'camdram/venue'

module Camdram
  class Event < Base
    include API
    attr_accessor :id, :start_date, :end_date, :time, :other_venue, :show, :venue

    # Instantiate a new Event object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Event] The new Event object.
    def initialize(options = {})
      super(options)
      @show = Show.new( @show ) unless @show.nil?
      @venue = Venue.new( @venue ) unless @venue.nil?
    end

    # Return a hash of the image's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        start_date: start_date,
        end_date: end_date,
        time: time,
        other_venue: other_venue,
        show: show,
        venue: venue,
      }
    end
  end
end
