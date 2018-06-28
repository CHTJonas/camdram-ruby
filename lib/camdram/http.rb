require 'net/http'
require 'camdram/error'

module Camdram
  class HTTP

    # Sends a HTTP-get request to the Camdram API
    #
    # @param url [URI] The uri to send the request to.
    # @param max_redirects [Integer] The maximum number of redirects.
    # @param user_agent [String] The User-Agent header to send
    # @raise [RedirectError] Error raised when too many redirects occur.
    # @return [String]
    def self.get(uri, max_redirects = 10, user_agent)
      # Raise an exception if we enter a redirect loop
      if max_redirects == 0
        new Error::RedirectError(310, 'Too many redirects', nil)
      end
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
        request = Net::HTTP::Get.new(uri)
        request['User-Agent'] = user_agent
        http.request(request)
      }
      case response
      when Net::HTTPSuccess then
        response.body
      when Net::HTTPRedirection then
        location = response['location']
        warn "redirected to #{location}"
        fetch(location, limit - 1)
      else
        Error.for(response)
      end
    end
  end
end
