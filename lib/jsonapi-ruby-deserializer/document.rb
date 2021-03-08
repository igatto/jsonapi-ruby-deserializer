# frozen_string_literal: true

module JSONAPI
  module Ruby
    module Deserializer
      class Document
        attr_accessor :jsonapi, :meta, :links, :data, :included, :index, :errors

        def initialize(document, link_data: true)
          @jsonapi = parse_jsonapi!(document['jsonapi'])
          @meta = parse_meta!(document['meta'])
          @links = parse_links!(document['links'])
          @data = parse_resource!(document['data'])
          @included = parse_resource!(document['included'])
          @index = create_index!
          @errors = parse_errors!(document['errors'])
          link_data! if link_data
        end

        def parse_resource!(data)
          return if data.nil? || data.empty?

          data.kind_of?(Array) ? data.map! { |h| Resource.new(h) } : Resource.new(data)
        end

        def parse_links!(data)
          return if data.nil? || data.empty?

          Links.new(data)
        end

        def parse_meta!(data)
          return if data.nil? || data.empty?

          Meta.new(data)
        end

        def parse_jsonapi!(data)
          return if data.nil? || data.empty?

          Jsonapi.new(data)
        end

        def create_index!
          return if @included.nil? || @included.empty?

          {}.tap do |h|
            @included.each do |resource|
              resource_identifier = [resource.type, resource.id]
              h[resource_identifier] = resource
            end
          end
        end

        def parse_errors!(data)
          return if data.nil? || data.empty?

          data.kind_of?(Array) ? data.map! { |h| Errors.new(h) } : Errors.new(data)
        end

        def link_data!
          return if @included.nil? || @included.empty?

          (Array(@data) + @included).each do |resource|
            next if resource.relationships.to_a.empty?

            resource.relationships.to_a.each do |relation|
              resource.relationships.send(relation.to_sym).data = fetch_relation(resource.relationships.send(relation.to_sym).data)
            end
          end
        end

        def fetch_relation(data)
          if data.kind_of?(Array)
            data.map { |element| index[[element.type, element.id]] || element }
          else
            index[[data.type, data.id]] || data
          end
        end
      end
    end
  end
end
