# frozen_string_literal: true

require 'date'
require 'camdram/base'
require 'camdram/show'
require 'camdram/venue'

module Camdram
  class Event < Base
    attr_accessor :start_at, :repeat_until, :other_venue, :show, :venue

    # Instantiate a new Event object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Event] The new Event object.
    def initialize(*args)
      super(*args)
      @start_at = DateTime.parse(@start_at) unless @start_at.nil?
      @repeat_until = Date.parse(@repeat_until) unless @repeat_until.nil?
      @show = Show.new(@show, @client_instance) unless @show.nil?
      @venue = Venue.new(@venue, @client_instance) unless @venue.nil?
    end

    # Return a hash of the event's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        start_at: start_at,
        repeat_until: repeat_until,
        other_venue: other_venue,
        show: show,
        venue: venue,
      }
    end
  end
end
