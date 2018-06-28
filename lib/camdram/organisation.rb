require 'camdram/base'

module Camdram
  class Organisation < Base
    attr_accessor :name, :description, :twitter_id, :short_name, :slug, :type

    # Return a hash of the organisation's attributes
    #
    # @return [Hash]
    def info
      {
        id: id,
        name: name,
        description: description,
        twitter_id: twitter_id,
        short_name: short_name,
        slug: slug,
        type: type,
      }
    end

    # Return the unique Camdram URL of the organisation
    #
    # @return [String]
    def url
      "/societies/#{slug}.json"
    end
  end
end
