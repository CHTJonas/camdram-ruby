# frozen_string_literal: true

require 'date'
require 'camdram/base'
require 'camdram/society'
require 'camdram/venue'

module Camdram
  class News < Base
    attr_accessor :entity, :remote_id, :source, :picture, :body, :posted_at, :created_at

    # Instantiate a new News object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::News] The new News object.
    def initialize(*args)
      super(*args)
      @entity = case @entity[:_type]
        when "society" then Society.new(@entity, @client_instance)
        when "venue" then Venue.new(@entity, @client_instance)
      end unless @entity.nil?
      @posted_at = DateTime.parse(@posted_at) unless @posted_at.nil?
      @created_at = DateTime.parse(@created_at) unless @created_at.nil?
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
