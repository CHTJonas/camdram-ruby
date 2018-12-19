require 'camdram/http'

module Camdram
  class Base
    attr_reader :id

    # Instantiate a new object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Object] The new object.
    def initialize(*args)
      raise ArgumentError, 'Too few arguments' if args.length < 2
      raise ArgumentError, 'Too many arguments' if args.length > 2
      options, key = *args
      set_from_hash(options)
      @instance_key = key
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
