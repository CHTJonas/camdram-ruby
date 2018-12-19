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
    # @return [Camdram::Role] The new Role object.
    def initialize(*args)
      super(*args)
      @show = Show.new(@show, @instance_key) unless @show.nil?
      @person = Person.new(@person, @instance_key) unless @person.nil?
    end

    # Return a hash of the roles's attributes
    #
    # @return [Hash] Hash with symbolized keys.
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
