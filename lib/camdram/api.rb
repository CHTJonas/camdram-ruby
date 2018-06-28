require 'json'
require 'camdram/http'

module Camdram
  module API

    # Send a HTTP get request and parse the returned JSON
    #
    # @param url [String] The URL to send the HTTP get request to
    # @param access_token [String] The OAuth token for the API
    # @return [Hash]
    def get(url, access_token, user_agent)
      uri = URI("#{url}?access_token=#{access_token}")
      response = HTTP.get(uri, 3, user_agent)
      JSON.parse(response, symbolize_names: true)
    end

    # Return an array of objects of the given class
    #
    # @param url [String] The URL to send the HTTP get request to
    # @param access_token [String] The OAuth token for the API
    # @param object [Object] The class to instantiate
    # @return [Array] An array of Objects of class object
    def get_array(url, access_token, object, user_agent)
      json = get(url, access_token, user_agent)
      objects = Array.new
      json.each do |obj|
        objects << object.new( obj )
      end
      return objects
    end

  end
end
