# frozen_string_literal: true

require 'camdram/base'
require 'camdram/show'
require 'camdram/person'

module Camdram
  class Role < Base
    attr_accessor :person_name, :person_slug, :type, :role, :order, :tag, :show, :person

    # Instantiate a new Role object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Role] The new Role object.
    def initialize(*args)
      super(*args)
      @show = Show.new(@show, @client_instance) unless @show.nil?
      @person = Person.new(@person, @client_instance) unless @person.nil?
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
        tag: tag,
        show: show,
        person: person,
      }
    end
  end
end
