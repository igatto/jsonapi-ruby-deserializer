# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'
require 'json'

describe JSONAPI::Ruby::Deserializer::Document do
  subject(:parsed_document) { JSONAPI::Ruby::Deserializer::Document.new(document) }

  let(:document) { JSON.parse(File.open('spec/fixtures/multiple_resources.json').read) }

  context 'document contains multiple resources' do
    it 'checks every feature' do
      expect(parsed_document.meta.license).to eq('MIT')
      expect(parsed_document.meta.authors).to eq(['James Smith', 'Maria Hernandez'])
      expect(parsed_document.data[0].attributes).to eq({'title' => 'JSON:API paints my bikeshed!'})
      expect(parsed_document.data[0].title).to eq('JSON:API paints my bikeshed!')
      expect(parsed_document.data[0].author.first_name).to eq('Dan')
      expect(parsed_document.data[0].comments[0].body).to eq('First!')
      expect(parsed_document.links.self).to eq('http://example.com/articles')
      expect(parsed_document.data[0].comments[0].links.self).to eq('http://example.com/comments/5')
      expect(parsed_document.data[0].links.self).to eq('http://example.com/articles/1')
    end
  end
end
