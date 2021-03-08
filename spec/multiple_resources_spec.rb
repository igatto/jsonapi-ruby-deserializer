# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'
require 'json'

describe JSONAPI::Ruby::Deserializer::Document do
  let(:json) { JSON.parse(File.open('spec/fixtures/multiple_resources.json').read) }

  context 'document contains multiple resources' do
    subject(:document) { JSONAPI::Ruby::Deserializer::Document.new(json) }

    it 'checks every feature' do
      expect(document.jsonapi.version).to eq('1.0')
      expect(document.data[0].id).to eq('1')
      expect(document.data[0].type).to eq('articles')
      expect(document.meta.license).to eq('MIT')
      expect(document.meta.authors).to eq(['James Smith', 'Maria Hernandez'])
      expect(document.data[0].attributes.to_h).to eq({'title' => 'JSON:API paints my bikeshed!'})
      expect(document.links.self).to eq('http://example.com/articles')
      expect(document.data[0].relationships.comments.data[0].links.self).to eq('http://example.com/comments/5')
      expect(document.data[0].links.self).to eq('http://example.com/articles/1')
    end
  end

  context 'document contains multiple resources' do
    subject(:document) { JSONAPI::Ruby::Deserializer::Document.new(json, link_data: false) }
    it 'without linking data' do
      expect(document.data[0].id).to eq('1')
      expect(document.data[0].type).to eq('articles')
      expect(document.meta.license).to eq('MIT')
      expect(document.data[0].relationships.author.data.attributes.to_h).to eq({})
    end
  end
end
