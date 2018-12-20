require 'camdram/http'

module Camdram
  module API

    private

    # Send a HTTP get request and parse the returned JSON
    #
    # @param url_slug [String] The URL slug to send the HTTP get request to.
    # @return [Hash] A hash parsed from the JSON response with symbolized keys.
    def get(url_slug)
      response = HTTP.instance(@client_instance).get(url_slug)
      puts response.parsed.inspect if ENV['DEBUG']
      response.parsed
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

    # Split a JSON array into a Ruby array of object of the specified class
    #
    # @param json [Array] The JSON array to itterate through.
    # @param object [Object] The class to instantiate.
    # @return [Array] An array of objects of the specified class.
    def split_object(json, object)
      objects = Array.new
      json.each do |obj|
        objects << object.new(obj, @client_instance)
      end
      return objects
    end

  end
end
