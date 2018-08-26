require 'camdram/base'
require 'camdram/api'
require 'camdram/show'
require 'camdram/organisation'
require 'camdram/venue'
require 'camdram/person'

module Camdram
  class Search < Base
    include API
    attr_accessor :name, :slug, :start_at, :rank, :entity_type

    # Return the correct Ruby object referenced by the search entity
    #
    # @return [Object] The Ruby object that is referenced by the search entity.
    def entity
      cls = nil
      case entity_type
        when "show" then cls = Show
        when "society" then cls = Organisation
        when "venue" then cls = Venue
        when "person" then cls = Person
      end
      url = "#{cls.url}/#{slug}.json"
      response = get(url)
      return cls.new(response, @http)
    end

    # Return a hash of the search entity's attributes
    #
    # @return [Hash] Hash with symbolized keys
    def info
      {
        name: name,
        slug: slug,
        start_at: start_at,
        rank: rank,
        id: id,
        entity_type: entity_type,
      }
    end
  end
end
