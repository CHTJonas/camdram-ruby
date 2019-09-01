# frozen_string_literal: true

require 'camdram/base'
require 'camdram/api'
require 'camdram/event'

module Camdram
  class Diary < Base
    include API
    attr_accessor :events, :labels, :weeks, :periods, :start_date, :end_date

    class Week < Base
      attr_accessor :start_at, :text

      # Instantiate a new Week object from a JSON hash
      #
      # @param options [Hash] A single JSON hash with symbolized keys.
      # @return [Camdram::Diary::Week] The new Week object.
      def initialize(*args)
        super(*args)
        @start_at = Date.parse(@start_at) unless @start_at.nil?
      end
    end

    class Period < Base
      attr_accessor :start_at, :end_at, :text

      # Instantiate a new Period object from a JSON hash
      #
      # @param options [Hash] A single JSON hash with symbolized keys.
      # @return [Camdram::Diary::Period] The new Period object.
      def initialize(*args)
        super(*args)
        @start_at = Date.parse(@start_at) unless @start_at.nil?
        @end_at = Date.parse(@end_at) unless @end_at.nil?
      end
    end

    # Instantiate a new Diary object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Event] The new Diary object.
    def initialize(*args)
      super(*args)
      @events = split_object( @events, Event ) unless @events.nil?
      @weeks = []
      @periods = []
      @labels.each do |label|
        case label["type"]
        when "week" then
          @weeks << Week.new(label, @client_instance)
        when "period" then
          @periods << Period.new(label, @client_instance)
        end
      end
      @labels = nil
      @start_date = Date.parse(@start_date) unless @start_date.nil?
      @end_date = Date.parse(@end_date) unless @end_date.nil?
    end

    # Return a hash of the diary's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        events: events,
        weeks: weeks,
        periods: periods,
        start_date: start_date,
        end_date: end_date,
      }
    end
  end
end
