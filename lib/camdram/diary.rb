require 'camdram/base'
require 'camdram/api'
require 'camdram/event'

module Camdram
  class Diary < Base
    include API
    attr_accessor :events

    # Instantiate a new Diary object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Event] The new Diary object.
    def initialize(options = {})
      super(options)
      @events = split_object( @events, Event ) unless @events.nil?
    end

    # Return a hash of the diary's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        events: events,
      }
    end
  end
end
