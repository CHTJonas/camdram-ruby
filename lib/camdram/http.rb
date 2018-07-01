require 'net/http'
require 'camdram/error'

module Camdram
  class HTTP

    # Initializes a new HTTP object
    #
    # @param api_token [String] The API token to use to authenticate requests.
    # @param base_url [String] The API hostname to use when sending API requests.
    # @param user_agent [String] The User-Agent header to send to the server.
    # @return [Camdram::HTTP]
    def initialize(api_token, base_url, user_agent)
      @api_token = api_token
      @base_url = base_url
      @user_agent = user_agent
    end

    # Sends a HTTP-get request to the Camdram API
    #
    # @param url_slug [String] The URL slug to send the request to.
    # @param max_redirects [Integer] The maximum number of redirects.
    # @raise [RedirectError] Error raised when too many redirects occur.
    # @return [String]
    def get(url_slug, max_redirects = 10)
      # Raise an exception if we enter a redirect loop
      if max_redirects == 0
        new Error::RedirectError(310, 'Too many redirects', nil)
      end
      url = @base_url + url_slug
      uri = URI(url)
      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
        request = Net::HTTP::Get.new(uri)
        request['Authorization'] = "Bearer #{@api_token}"
        request['User-Agent'] = @user_agent
        http.request(request)
      }
      case response
      when Net::HTTPSuccess then
        response.body
      when Net::HTTPRedirection then
        location = response['location']
        warn "redirected to #{location}"
        get(location, max_redirects - 1)
      else
        Error.for(response)
      end
    end
  end
end
