# frozen_string_literal: true

require 'jsonapi-ruby-deserializer/parser'

module JSONAPI
  module Ruby
    module Deserializer
      class Resource
        include JSONAPI::Ruby::Deserializer::Parser
        attr_accessor :id, :type, :attributes, :relationships, :links, :meta

        def initialize(data)
          @id = data['id']
          @type = data['type']
          @attributes = parse_attributes!(data['attributes'])
          @links = parse_links!(data['links'])
          @meta = parse_meta!(data['meta'])
          @relationships = parse_relationships!(data['relationships'])
        end

        def parse_relationships!(data)
          return if data.nil? || data.empty?

          Relationships.new(data)
        end

        def parse_links!(data)
          return if data.nil? || data.empty?

          Links.new(data)
        end

        def parse_meta!(data)
          return if data.nil? || data.empty?

          Meta.new(data)
        end

        def parse_attributes!(data)
          return if data.nil? || data.empty?

          Attributes.new(data)
        end
      end
    end
  end
end
