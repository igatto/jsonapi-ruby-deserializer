# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'
require 'json'

describe JSONAPI::Ruby::Deserializer::Document do
  subject(:document) { JSONAPI::Ruby::Deserializer::Document.new(json) }

  let(:json) { JSON.parse(File.open('spec/fixtures/singular_resource.json').read) }

  context 'document contains singular resource' do
    it 'checks every feature' do
      expect(document.links.self).to eq('http://example.com/articles')
      expect(document.meta.license).to eq('MIT')
      expect(document.meta.authors).to eq(['James Smith', 'Maria Hernandez'])
      expect(document.data.attributes.title).to eq('JSON:API paints my bikeshed!')
      expect(document.data.attributes.to_h).to eq({'title' => 'JSON:API paints my bikeshed!'})
      expect(document.data.relationships.comments.data[0].id).to eq('5')
      expect(document.data.relationships.comments.data[1].attributes.to_h).to eq({'body'=>'I like XML better'})
    end
  end
end
