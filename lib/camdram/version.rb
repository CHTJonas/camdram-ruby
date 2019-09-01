# frozen_string_literal: true

module Camdram
  module Version
    class << self

      # Returns the major revision number of the Camdram Ruby client library in use
      #
      # @return [Integer] The major revision number.
      def major
        2
      end

      # Return the minor revision number of the Camdram Ruby client library in use
      #
      # @return [Integer] The minor revision number.
      def minor
        0
      end

      # Returns the patch revision number of the Camdram Ruby client library in use
      #
      # @return [Integer] The patch revision number.
      def patch
        0
      end

      # Returns the version string of the Camdram Ruby client library in use
      #
      # @return [String] The version formatted as a string.
      def to_s
        "#{major}.#{minor}.#{patch}".freeze
      end

      # Returns the version array of the Camdram Ruby client library in use
      #
      # @return [Array] The version formatted as an array.
      def to_a
        [major, minor, patch]
      end

      # Returns the version hash of the Camdram Ruby client library in use
      #
      # @return [Hash] The version formatted as a hash.
      def to_h
        {
          major: major,
          minor: minor,
          patch: patch,
        }
      end
    end
  end
end
