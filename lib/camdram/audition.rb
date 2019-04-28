require 'date'
require 'camdram/base'
require 'camdram/show'

module Camdram
  class Audition < Base
    attr_accessor :start_at, :end_at, :location, :show

    # Instantiate a new Audition object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Audition] The new Audition object.
    def initialize(*args)
      super(*args)
      @start_at = DateTime.parse(@start_at, @client_instance) unless @start_at.nil?
      @end_at = DateTime.parse(@end_at, @client_instance) unless @end_at.nil?
      @show = Show.new(@show, @client_instance) unless @show.nil?
    end

    # Return a hash of the audition's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        start_at: start_at,
        end_at: end_at,
        location: location,
        show: show,
      }
    end
  end
end
