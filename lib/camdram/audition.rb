require 'date'
require 'camdram/base'
require 'camdram/api'
require 'camdram/show'

module Camdram
  class Audition < Base
    include API
    attr_accessor :date, :start_time, :end_time, :location, :show

    # Instantiate a new Audition object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Audition] The new Audition object.
    def initialize(options = {})
      super(options)
      @date = Date.parse(@date) unless @date.nil?
      @start_time = DateTime.parse(@start_time) unless @start_time.nil?
      @end_time = DateTime.parse(@end_time) unless @end_time.nil?
      @show = Show.new(@show) unless @show.nil?
    end

    # Return a hash of the audition's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        date: date,
        start_time: start_time,
        end_time: end_time,
        location: location,
        show: show,
      }
    end
  end
end