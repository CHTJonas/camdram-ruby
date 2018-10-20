require 'camdram/base'
require 'camdram/api'
require 'camdram/organisation'
require 'camdram/venue'

module Camdram
  class News < Base
    include API
    attr_accessor :entity, :remote_id, :source, :picture, :body, :posted_at, :created_at

    # Instantiate a new News object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::News] The new News object.
    def initialize(options = {})
      super(options)
      @entity = case @entity[:_type]
        when "society" then Organisation.new( @entity )
        when "venue" then Venue.new( @entity )
      end unless @entity.nil?
    end

    # Return a hash of the news item's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        entity: entity,
        remote_id: remote_id,
        source: source,
        picture: picture,
        body: body,
        posted_at: posted_at,
        created_at: created_at,
      }
    end
  end
end
