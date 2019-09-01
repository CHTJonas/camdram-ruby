# frozen_string_literal: true

require 'date'
require 'mime/types'
require 'camdram/base'
require 'camdram/api'
require 'camdram/refreshable'

module Camdram
  class Image < Base
    include API, Refreshable
    attr_accessor :filename, :created_at, :width, :height, :extension, :type

    # Instantiate a new Image object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Image] The new Image object.
    def initialize(*args)
      super(*args)
      @created_at = DateTime.parse(@created_at) unless @created_at.nil?
      @type = MIME::Types[@type].first unless @type.nil?
    end

    # Return a hash of the image's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        filename: filename,
        created_at: created_at,
        width: width,
        height: height,
        extension: extension,
        type: type,
      }
    end

    # Return the image URL
    #
    # @return [String] The image URL.
    def url
      "/media/cache/preview/#{filename}"
    end
  end
end
