require 'camdram/base'
require 'camdram/api'

module Camdram
  class Person < Base
    include API
    attr_accessor :name, :slug, :entity_type

    # Return a hash of the person's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        name: name,
        slug: slug,
        entity_type: entity_type,
      }
    end

    # Returns the URL+slug of the person
    #
    # @return [String] The full URL and slug.
    def url_slug
      "#{self.class.url}/#{slug}.json"
    end

    # Returns the URL stub assocaited with all people
    #
    # @return [String] The URL stub.
    def self.url
      '/people'
    end
  end
end
