# frozen_string_literal: true

require 'jsonapi-ruby-deserializer/parser'

module JSONAPI
  module Ruby
    module Deserializer
      class Resource
        include JSONAPI::Ruby::Deserializer::Parser
        attr_accessor :id, :type, :attributes, :relationships, :links

        def initialize(data)
          @id = data['id']
          @type = data['type']
          @attributes = data['attributes']
          @links = parse_links!(data['links'])
          parse!(@attributes)
          parse_relationships!(data['relationships']) if data['relationships']
        end

        def parse_relationships!(relationships)
          @relationships = {}
          (relationships || {}).map do |key, h|
            @relationships[key] = Relationship.new(h)
          end
        end

        def parse_links!(data)
          return if data.nil?

          Links.new(data)
        end

        def link_data!(index)
          @relationships.each do |relation_name, relation_body|
            self.class.send(:attr_accessor, relation_name)
            instance_variable_set("@#{relation_name}", fetch_relation(relation_body.data, index))
          end
        end

        def fetch_relation(data, index)
          if data.kind_of?(Array)
            data.map { |element| index[[element.type, element.id]] }
          else
            index[[data.type, data.id]]
          end
        end
      end
    end
  end
end
