module Camdram
  class TimePeriod < Base
    include API
    attr_accessor :short_name, :name, :full_name, :slug, :start_at, :end_at

    # Instantiate a new TimePeriod object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::TimePeriod] The new TimePeriod object.
    def initialize(*args)
      super(*args)
      @start_at = DateTime.parse(@start_at) unless @start_at.nil?
      @end_at = DateTime.parse(@end_at) unless @end_at.nil?
    end

    # Return a hash of the time period's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        short_name: short_name,
        name: name,
        full_name: full_name,
        slug: slug,
        start_at: start_at,
        end_at: end_at,
      }
    end
  end
end
