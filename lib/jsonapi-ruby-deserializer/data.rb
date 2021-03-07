# frozen_string_literal: true

require 'jsonapi-ruby-deserializer/parser'

module JSONAPI
  module Ruby
    module Deserializer
      class Data
        include JSONAPI::Ruby::Deserializer::Parser
        attr_accessor :id, :type

        def initialize(data)
          @id = data['id']
          @type = data['type']
        end
      end
    end
  end
end
