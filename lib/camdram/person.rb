require 'camdram/base'
require 'camdram/api'
require 'camdram/refreshable'
require 'camdram/role'

module Camdram
  class Person < Base
    include API, Refreshable
    attr_accessor :name, :description, :slug

    # Gets an array of roles the person has been in
    #
    # @return [Array] An array of Role objects.
    def roles
      roles_url = "#{self.class.url}/#{slug}/roles.json"
      response = get(roles_url)
      split_object( response, Role )
    end

    def role_tags
      tags = Set.new
      roles.each do |role|
        tag = role.tag
        tags.add(tag) unless tag.nil?
      end
      tags
    end

    # Return a hash of the person's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        description: description,
        name: name,
        slug: slug,
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
