# frozen_string_literal: true

require 'jsonapi-ruby-deserializer/parser'

module JSONAPI
  module Ruby
    module Deserializer
      class Links
        include JSONAPI::Ruby::Deserializer::Parser

        def initialize(data)
          parse!(data)
        end
      end
    end
  end
end
