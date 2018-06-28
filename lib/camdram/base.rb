require 'camdram/http'

module Camdram
  class Base
    attr_accessor :id

    # Instantiate a new Base object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys
    # @return [Base]
    def initialize(options = {})
      set_from_hash(options)
    end

    # Update the object from it's unqiue Camdram URL
    #
    # @return [Base]
    def update!(base_url)
      url = base_url + self.url
      uri = URI( url )
      response = HTTP.get(uri, 3)
      json = JSON.parse(response, symbolize_names: true)
      set_from_hash(json)
      return self
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
