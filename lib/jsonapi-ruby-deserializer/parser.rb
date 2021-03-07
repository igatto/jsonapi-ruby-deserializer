# frozen_string_literal: true

module JSONAPI
  module Ruby
    module Deserializer
      module Parser
        def parse!(data)
          data.each do |field, value|
            instance_variable_set("@#{field}", value)
            self.class.send(:attr_accessor, field.to_sym)
          end
        end
      end
    end
  end
end
