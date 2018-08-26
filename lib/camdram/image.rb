require 'camdram/base'
require 'camdram/api'

module Camdram
  class Image < Base
    include API
    attr_accessor :filename, :created_at, :width, :height, :extension, :type

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
