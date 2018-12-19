require 'camdram/base'
require 'camdram/api'
require 'camdram/show'
require 'camdram/society'
require 'camdram/venue'
require 'camdram/person'

module Camdram
  class Search < Base
    include API
    attr_accessor :name, :slug, :show_count, :last_active, :start_at, :rank, :entity_type

    # Instantiate a new Search object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Search] The new Search object.
    def initialize(*args)
      super(*args)
      @start_at = Date.parse(@start_at) unless @start_at.nil?
      @last_active = Date.parse(@last_active) unless @last_active.nil?
    end

    # Return the correct Ruby object referenced by the search entity
    #
    # @return [Object] The Ruby object that is referenced by the search entity.
    def entity
      klass = case entity_type
        when "show" then Show
        when "society" then Society
        when "venue" then Venue
        when "person" then Person
      end
      url = "#{klass.url}/#{slug}.json"
      response = get(url)
      return klass.new(response, @client_instance)
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
