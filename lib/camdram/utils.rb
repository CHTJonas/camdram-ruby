module Camdram
  module Utils
    # @!visibility private
    def inspect
      str = instance_variables.collect do |v|
        unless v == :@client_instance
          "#{v.to_s}=#{instance_variable_get(v).inspect}"
        end
      end.compact.join(', ')
      "#<#{self.class} #{str}>"
    end
  end
end
