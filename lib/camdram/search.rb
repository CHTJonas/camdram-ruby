require 'camdram/base'
require 'camdram/api'
require 'camdram/show'
require 'camdram/organisation'
require 'camdram/venue'
require 'camdram/person'

module Camdram
  class Search < Base
    include API
    attr_accessor :name, :slug, :show_count, :last_active, :start_at, :rank, :entity_type

    # Return the correct Ruby object referenced by the search entity
    #
    # @return [Object] The Ruby object that is referenced by the search entity.
    def entity
      klass = case entity_type
        when "show" then Show
        when "society" then Organisation
        when "venue" then Venue
        when "person" then Person
      end
      url = "#{klass.url}/#{slug}.json"
      response = get(url)
      return klass.new(response)
    end

    # Return a hash of the search entity's attributes
    #
    # @return [Hash] Hash with symbolized keys.
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
