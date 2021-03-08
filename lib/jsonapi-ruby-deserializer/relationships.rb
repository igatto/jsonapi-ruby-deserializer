# frozen_string_literal: true

require 'jsonapi-ruby-deserializer/parser'

module JSONAPI
  module Ruby
    module Deserializer
      class Relationships
        include JSONAPI::Ruby::Deserializer::Parser
        attr_accessor :to_a

        def initialize(data)
          @to_a = []
          data.map do |key, h|
            @to_a << key
            self.class.send(:attr_accessor, key)
            instance_variable_set("@#{key}", Document.new(h))
          end
        end
      end
    end
  end
end
