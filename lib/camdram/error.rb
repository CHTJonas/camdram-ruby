# frozen_string_literal: true

module Camdram
  module Error
    class Misconfigured < RuntimeError; end
    class NoApiKey < RuntimeError; end
  end
end
