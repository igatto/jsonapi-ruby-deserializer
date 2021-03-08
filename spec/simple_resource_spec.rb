# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'
require 'json'

describe JSONAPI::Ruby::Deserializer::Document do
  subject(:document) { JSONAPI::Ruby::Deserializer::Document.new(json) }

  let(:json) { JSON.parse(File.open('spec/fixtures/simple_resource.json').read) }

  context 'document contains very simple resource' do
    it 'checks every feature' do
      expect(document.data.type).to eq('articles')
      expect(document.data.meta.example).to eq('tag')
    end
  end
end
