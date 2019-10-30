# frozen_string_literal: true

require 'camdram/base'
require 'camdram/api'
require 'camdram/refreshable'
require 'camdram/society'
require 'camdram/performance'
require 'camdram/image'
require 'camdram/role'

module Camdram
  class Show < Base
    include API, Refreshable
    attr_accessor :name, :description, :image, :slug, :author, :prices, :category, :performances, :theme_color, :online_booking_url, :societies

    # Instantiate a new Show object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Show] The new Show object.
    def initialize(*args)
      super(*args)
      @societies = split_object(@societies, Society) unless @societies.nil?
      @performances = split_object(@performances, Performance) unless @performances.nil?
      @image = Image.new(@image, @client_instance) unless @image.nil?
    end

    # Gets an array of roles associated with the shows
    #
    # @return [Array] An array of Role objects.
    def roles
      roles_url = "#{self.class.url}/#{slug}/roles.json"
      response = get(roles_url)
      split_object( response, Role )
    end

    # Return a hash of the shows's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        name: name,
        description: description,
        image: image,
        slug: slug,
        author: author,
        prices: prices,
        category: category,
        performances: performances,
        online_booking_url: online_booking_url,
        societies: societies,
      }
    end

    # Returns the URL+slug of the show
    #
    # @return [String] The full URL and slug.
    def url_slug
      "#{self.class.url}/#{slug}.json"
    end

    # Returns the URL stub assocaited with all shows
    #
    # @return [String] The URL stub.
    def self.url
      '/shows'
    end
  end
end
