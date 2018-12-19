require 'date'
require 'camdram/base'
require 'camdram/api'
require 'camdram/show'

module Camdram
  class TechieAdvert < Base
    include API
    attr_accessor :show, :positions, :contact, :deadline, :deadline_time, :expiry, :tech_extra, :last_updated

    # Instantiate a new TechieAdvert object from a JSON hash
    #
    # @param options [Hash] A single JSON hash with symbolized keys.
    # @return [Camdram::TechieAdvert] The new TechieAdvert object.
    def initialize(*args)
      super(*args)
      @show = Show.new(@show, @instance_key) unless @show.nil?
      @deadline_time = DateTime.parse(@deadline_time) unless @deadline_time.nil?
      @expiry = Date.parse(@expiry) unless @expiry.nil?
      @last_updated = Date.parse(@last_updated) unless @last_updated.nil?
    end

    # Return a hash of the advert's attributes
    #
    # @return [Hash] Hash with symbolized keys.
    def info
      {
        id: id,
        show: show,
        positions: positions,
        contact: contact,
        deadline: deadline,
        deadline_time: deadline_time,
        expiry: expiry,
        tech_extra: tech_extra,
        last_updated: last_updated,
      }
    end
  end
end
