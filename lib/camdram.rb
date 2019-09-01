# frozen_string_literal: true

module Camdram
  class << self

    # Returns the URL of the Camdram server to send request to
    #
    # @return [String] The server URL.
    def base_url
      'https://www.camdram.net'
    end

    # Returns the version of Camdram Ruby client library in use
    #
    # @return [String] The client version.
    def version
      Camdram::Version.to_s
    end
  end
end
