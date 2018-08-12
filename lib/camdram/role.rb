require 'camdram/base'
require 'camdram/api'
require 'camdram/show'
require 'camdram/person'

module Camdram
  class Role < Base
    attr_accessor :person_name, :person_slug, :type, :role, :order, :show, :person

    # Instantiate a new Role object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Role] The new Role object.
    def initialize(options = {}, http = nil)
      super(options)
      # @show = Show.new( @show, @http ) if !@show.nil?
      # @person = Person.new( @person, @http ) if !@person.nil?
    end

    # Return a hash of the roles's attributes
    #
    # @return [Hash] Hash with symbolized keys
    def info
      {
        person_name: person_name,
        person_slug: person_slug,
        id: id,
        type: type,
        role: role,
        order: order,
        show: show,
        person: person,
      }
    end
  end
end
