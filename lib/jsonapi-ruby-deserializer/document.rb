# frozen_string_literal: true

module JSONAPI
  module Ruby
    module Deserializer
      class Document
        attr_accessor :data, :included, :meta, :links, :index, :errors

        def initialize(document, link_data: true)
          @included = parse_resource!(document['included']) if document['included']
          @index = create_index!
          @data = parse_resource!(document['data'])
          @links = parse_links!(document['links'])
          @meta = parse_meta!(document['meta'])
          @errors = parse_errors!(document['errors'])
          link_data! if link_data
        end

        def parse_resource!(data)
          return if data.nil?

          data.kind_of?(Array) ? data.map! { |h| Resource.new(h) } : Resource.new(data)
        end

        def parse_links!(data)
          return if data.nil?

          Links.new(data)
        end

        def parse_meta!(data)
          return if data.nil?

          Meta.new(data)
        end

        def create_index!
          return if @included.nil?

          {}.tap do |h|
            @included.each do |resource|
              resource_identifier = [resource.type, resource.id]
              h[resource_identifier] = resource
            end
          end
        end

        def parse_errors!(data)
          return if data.nil?

          data.kind_of?(Array) ? data.map! { |h| Errors.new(h) } : Errors.new(data)
        end

        def link_data!
          return if @included.nil?

          (Array(@data) + @included).each do |resource|
            next if resource.relationships.nil?

            resource.link_data!(@index)
          end
        end
      end
    end
  end
end
