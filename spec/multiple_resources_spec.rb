# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'
require 'json'

describe JSONAPI::Ruby::Deserializer::Document do
  subject(:document) { JSONAPI::Ruby::Deserializer::Document.new(json) }

  let(:json) { JSON.parse(File.open('spec/fixtures/multiple_resources.json').read) }

  context 'document contains multiple resources' do
    it 'checks every feature' do
      expect(document.data[0].id).to eq('1')
      expect(document.data[0].type).to eq('articles')
      expect(document.meta.license).to eq('MIT')
      expect(document.meta.authors).to eq(['James Smith', 'Maria Hernandez'])
      expect(document.data[0].attributes).to eq({'title' => 'JSON:API paints my bikeshed!'})
      expect(document.data[0].title).to eq('JSON:API paints my bikeshed!')
      expect(document.data[0].author.data.first_name).to eq('Dan')
      expect(document.data[0].comments.data[0].body).to eq('First!')
      expect(document.links.self).to eq('http://example.com/articles')
      expect(document.data[0].comments.data[0].links.self).to eq('http://example.com/comments/5')
      expect(document.data[0].links.self).to eq('http://example.com/articles/1')
    end
  end
end
