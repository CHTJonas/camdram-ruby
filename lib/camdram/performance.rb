require 'date'
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
    # @return [Camdram::Performance] The new Performance object.
    def initialize(*args)
      super(*args)
      @start_date = Date.parse(@start_date) unless @start_date.nil?
      @end_date = Date.parse(@end_date) unless @end_date.nil?
      @time = DateTime.parse(@time) unless @time.nil?
      @venue = Venue.new(@venue, @client_instance) unless @venue.nil?
    end

    # Return a hash of the performance's attributes
    #
    # @return [Hash] Hash with symbolized keys.
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
