require 'camdram/base'
require 'camdram/api'
require 'camdram/refreshable'
require 'camdram/society'
require 'camdram/venue'
require 'camdram/performance'
require 'camdram/image'
require 'camdram/role'

module Camdram
  class Show < Base
    include API, Refreshable
    attr_accessor :name, :description, :image, :slug, :author, :prices, :other_venue, :other_society, :category, :performances, :online_booking_url, :societies, :society, :venue

    # Instantiate a new Show object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Show] The new Show object.
    def initialize(*args)
      super(*args)
      @societies = split_object(@societies, Society) unless @societies.nil?
      @society = Society.new(@society, @client_instance) unless @society.nil?
      @venue = Venue.new(@venue, @client_instance) unless @venue.nil?
      @performances = split_object(@performances, Performance) unless @performances.nil?
      @image = Image.new(@image, @client_instance) unless @image.nil?
    end

    # @deprecated This field will soon be removed from the Camdram API. See the
    #  discussion at https://github.com/camdram/camdram/issues/541
    def other_venue
      warn 'Camdram::Show.other_venue is deprecated and will be removed in future versions' unless ENV['QUIET']
      @other_venue
    end

    # @deprecated This field will soon be removed from the Camdram API. See the
    #  discussion at https://github.com/camdram/camdram/issues/541
    def other_society
      warn 'Camdram::Show.other_society is deprecated and will be removed in future versions' unless ENV['QUIET']
      @other_society
    end

    # @deprecated This field will soon be removed from the Camdram API. See the
    #   discussion at https://github.com/camdram/camdram/pull/536#issuecomment-445069669
    def society
      warn 'Camdram::Show.society is deprecated and will be removed in future versions' unless ENV['QUIET']
      @society
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
        other_venue: other_venue,
        other_society: other_society,
        category: category,
        performances: performances,
        online_booking_url: online_booking_url,
        society: society,
        venue: venue,
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
