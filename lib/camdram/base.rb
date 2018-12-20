require 'camdram/http'

module Camdram
  class Base
    attr_reader :id

    # Instantiate a new object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @param key [Object] The Camdram::Client instance key for the API multiton.
    # @return [Object] The new object.
    def initialize(options = {}, key = nil)
      set_from_hash(options)
      @client_instance = key
    end

    private

    # Sets the object's instance variables from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    def set_from_hash(options)
      options.each do |key, value|
        # Only set the instance variable if the class or sub-class
        # has an associated attr_accessor for that variable
        instance_variable_set("@#{key}", value) if self.respond_to?(key)
      end
    end
  end
end
