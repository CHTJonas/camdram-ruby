require 'camdram/base'

module Camdram
  class Performance < Base
    attr_accessor :start_date, :end_date, :time, :other_venue

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
