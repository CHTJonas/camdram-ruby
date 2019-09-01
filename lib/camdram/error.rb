# frozen_string_literal: true

module Camdram
  module Error
    class NotConfigured < RuntimeError; end
    class MisConfigured < RuntimeError; end
    class NoApiKey < RuntimeError; end
  end
end
