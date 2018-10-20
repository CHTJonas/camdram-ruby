require 'singleton'
require 'net/http'
require 'camdram/error'
require 'camdram/version'

module Camdram
  class HTTP
    include Singleton
    attr_writer :api_token, :base_url, :user_agent

    # Sends a HTTP-get request to the Camdram API
    #
    # @param url_slug [String] The URL slug to send the request to.
    # @param max_redirects [Integer] The maximum number of redirects.
    # @raise [Camdram::Error::RedirectError] Error raised when too many redirects occur.
    # @return [String]
    def get(url_slug, max_redirects = 10)
      url = base_url + url_slug
      uri = URI(url)
      inner_get(uri, max_redirects)
    end

    # Returns true if the API access token is set
    #
    # @return [Boolean] Whether the API token is set or not.
    def api_token?
      !@api_token.nil? && !(blank?(@api_token))
    end

    # Returns the API URL that each HTTP request is sent to
    #
    # @return [String] The API hostname to send requests to.
    def base_url
      @base_url ||= Camdram::BASE_URL
    end

    # Returns the user agent header sent in each HTTP request
    #
    # @return [String] The user agent header to send with HTTP requests.
    def user_agent
      @user_agent ||= "Camdram Ruby v#{Camdram::VERSION}"
    end

    private

    # Returns true if a given string is blank
    #
    # @param string [String] The string to test.
    # @return [Boolean] True if blank, false otherwise.
    def blank?(string)
      string.respond_to?(:empty?) ? string.empty? : false
    end

    def inner_get(uri, max_redirects)
      # Raise an exception if we enter a redirect loop
      if max_redirects == 0
        new Error::RedirectError(310, 'Too many redirects', nil)
      end

      response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
        request = Net::HTTP::Get.new(uri)
        request['Authorization'] = "Bearer #{@api_token}" if !@api_token.nil?
        request['User-Agent'] = @user_agent if !@user_agent.nil?
        http.request(request)
      }

      case response
      when Net::HTTPSuccess then
        response.body
      when Net::HTTPRedirection then
        location = response['location']
        warn "redirected to #{location}"
        if location.start_with?('http')
          # Handles full URL and external redirects
          inner_get(URI(location), max_redirects - 1)
        else
          # Handles slug-based redirects
          get(location, max_redirects - 1)
        end
      else
        Error.for(response)
      end
    end
  end
end
