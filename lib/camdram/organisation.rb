require 'camdram/base'
require 'camdram/api'

module Camdram
  class Organisation < Base
    include API
    attr_accessor :name, :description, :twitter_id, :short_name, :slug, :type

    # Return a hash of the organisation's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        name: name,
        description: description,
        twitter_id: twitter_id,
        short_name: short_name,
        slug: slug,
        type: type,
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
