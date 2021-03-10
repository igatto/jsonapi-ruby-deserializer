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

        def to_h
          {}.tap do |h|
            self.instance_variables.each do |variable|
              h.merge!(variable.to_s[1..-1] => instance_variable_get(variable))
            end
          end
        end

        def method_missing(method, *args, &block)
          if args.empty?
            super
          else
            field = method[0...-1]
            instance_variable_set("@#{field}", *args)
            self.class.send(:attr_accessor, field.to_sym)
          end
        end
      end
    end
  end
end
