require 'json'
require 'camdram/http'

module Camdram
  module API
    attr_accessor :http

    # Instantiate a new object
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @param http [Camdram:HTTP] The HTTP class to which requests are sent.
    # @return [Object] The newly instantiated object.
    def initialize(options = {}, http = nil)
      super(options)
      @http = http
    end

    # Send a HTTP get request and parse the returned JSON
    #
    # @param url_slug [String] The URL slug to send the HTTP get request to.
    # @return [Hash] A hash parsed from the JSON response with symbolized keys.
    def get(url_slug)
      response = @http.get(url_slug, 3)
      JSON.parse(response, symbolize_names: true)
    end

    # Return an array of objects of the given class
    #
    # @param slug [String] The URL slug to send the HTTP get request to.
    # @param object [Object] The class to instantiate.
    # @return [Array] An array of objects of the specified class.
    def get_array(url_slug, object)
      json = get(url_slug)
      split_object(json, object)
    end

    # Update the object
    #
    # @return [Object] The object the method is called on.
    # @note The object this method is called on is updated 'in place'.
    def update!
      json = get(self.url_slug)
      set_from_hash(json)
      return self
    end

    private

    # Split a JSON array into a Ruby array of object of the specified class
    #
    # @param json [Array] The JSON array to itterate through.
    # @param object [Object] The class to instantiate.
    # @return [Array] An array of objects of the specified class.
    def split_object(json, object)
      objects = Array.new
      json.each do |obj|
        objects << object.new( obj )
      end
      return objects
    end

  end
end
