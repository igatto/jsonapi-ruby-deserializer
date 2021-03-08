# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'
require 'json'

describe JSONAPI::Ruby::Deserializer::Document do
  subject(:parsed_document) { JSONAPI::Ruby::Deserializer::Document.new(document) }

  let(:document) { JSON.parse(File.open('spec/fixtures/singular_resource.json').read) }

  context 'document contains multiple resources' do
    it 'checks every feature' do
      expect(parsed_document.links.self).to eq('http://example.com/articles')
      expect(parsed_document.meta.license).to eq('MIT')
      expect(parsed_document.meta.authors).to eq(['James Smith', 'Maria Hernandez'])
      expect(parsed_document.data.attributes).to eq({'title' => 'JSON:API paints my bikeshed!'})
      expect(parsed_document.data.title).to eq('JSON:API paints my bikeshed!')
      expect(parsed_document.data.author.data.first_name).to eq('Dan')
      expect(parsed_document.data.comments.data[0].body).to eq('First!')
    end
  end
end
