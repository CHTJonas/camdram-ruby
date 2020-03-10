# frozen_string_literal: true

module Camdram
  module Error
    class Misconfigured < RuntimeError; end
    class NoApiKey < RuntimeError; end
    class GenericException < StandardError; end
    class ClientError < GenericException; end
    class ServerError < GenericException; end
    class Timeout < GenericException; end
  end
end
