require 'date'
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
    def initialize(*args)
      super(*args)
      @start_date = Date.parse(@start_date) unless @start_date.nil?
      @end_date = Date.parse(@end_date) unless @end_date.nil?
      @time = DateTime.parse(@time) unless @time.nil?
      @show = Show.new(@show, @client_instance) unless @show.nil?
      @venue = Venue.new(@venue, @client_instance) unless @venue.nil?
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
