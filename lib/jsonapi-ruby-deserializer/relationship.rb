# frozen_string_literal: true

require 'jsonapi-ruby-deserializer/parser'

module JSONAPI
  module Ruby
    module Deserializer
      class Relationship
        include JSONAPI::Ruby::Deserializer::Parser
        attr_accessor :data, :included, :links, :attributes

        def initialize(data)
          @data = parse_data!(data['data'])
          @links = parse_links!(data['links'])
          @meta = parse_meta!(data['meta'])
        end

        def parse_data!(data)
          return nil if data.nil?

          data.kind_of?(Array) ? data.map! { |h| Data.new(h) } : Data.new(data)
        end

        def parse_links!(data)
          return nil if data.nil?

          Links.new(data)
        end

        def parse_meta!(data)
          return nil if data.nil?

          Meta.new(data)
        end
      end
    end
  end
end
