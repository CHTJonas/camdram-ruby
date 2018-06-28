require 'camdram/base'

module Camdram
  class Person < Base
    attr_accessor :name, :slug, :entity_type

    # Return a hash of the person's attributes
    #
    # @return [Hash] Hash with symbolized keys
    def info
      {
        id: id,
        name: name,
        slug: slug,
        entity_type: entity_type,
      }
    end

    # Return the unique Camdram URL slug of the person
    #
    # @return [String] The full URL slug
    def url_slug
      "/people/#{slug}.json"
    end
  end
end
