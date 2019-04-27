require 'camdram/utils'

module Camdram
  class Base
    include Utils
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

    # Removes the HTTP instance from any module contained within the Camdram
    # module namespace. Also removes the HTTP instance from any sub-objects as
    # well. This may be useful in some multi-threaded environments if you have
    # a connection pool of Camdram::Client objects.
    #
    # @return [Object] The object on which the method is called.
    def make_orphan
      @client_instance = -1 if instance_variable_defined?(:@client_instance)
      instance_variables.each do |var|
        value = instance_variable_get(var)
        if value.class.name.split('::').first == 'Camdram'
          value.make_orphan
        elsif value.class.name.split('::').first == 'Array'
          value.each { |v| v.make_orphan }
        end
      end
      self
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
