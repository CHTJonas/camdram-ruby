require 'camdram/base'
require 'camdram/api'
require 'camdram/image'

module Camdram
  class Organisation < Base
    include API
    attr_accessor :name, :description, :image, :facebook_id, :twitter_id, :short_name, :slug

    # Instantiate a new Organisation object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Organisation] The new Organisation object.
    def initialize(options = {}, http = nil)
      super(options, http)
      @image = Image.new( @image, @http ) if !@image.nil?
    end

    # Return a hash of the organisation's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        name: name,
        description: description,
        facebook_id: facebook_id,
        twitter_id: twitter_id,
        short_name: short_name,
        slug: slug,
      }
    end

    # Returns the URL+slug of the organisation
    #
    # @return [String] The full URL and slug.
    def url_slug
      "#{self.class.url}/#{slug}.json"
    end

    # Returns the URL stub assocaited with all organisations
    #
    # @return [String] The URL stub.
    def self.url
      '/societies'
    end
  end
end
