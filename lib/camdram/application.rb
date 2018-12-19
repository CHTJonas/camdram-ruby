require 'date'
require 'camdram/base'
require 'camdram/api'
require 'camdram/show'
require 'camdram/society'

module Camdram
  class Application < Base
    include API
    attr_accessor :show, :society, :text, :deadline_date, :further_info, :deadline_time

    # Instantiate a new Application object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::Application] The new Application object.
    def initialize(*args)
      super(*args)
      @show = Show.new(@show, @instance_key) unless @show.nil?
      @society = Society.new(@society, @instance_key) unless @society.nil?
      @deadline_date = Date.parse(@deadline_date, @instance_key) unless @deadline_date.nil?
      @deadline_time = DateTime.parse(@deadline_time, @instance_key) unless @deadline_time.nil?
    end

    # Return a hash of the vacancy application's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        show: show,
        society: society,
        text: text,
        deadline_date: deadline_date,
        further_info: further_info,
        deadline_time: deadline_time,
      }
    end
  end
end
