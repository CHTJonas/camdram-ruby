module Camdram
  module Refreshable

    # Update the object
    #
    # @return [Object] The object the method is called on.
    # @note The object this method is called on is updated 'in place'.
    def refresh!
      json = get(self.url_slug)
      self.send(:initialize, json, @client_instance)
      return self
    end
  end
end
