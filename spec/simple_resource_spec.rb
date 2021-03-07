# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'
require 'json'

describe JSONAPI::Ruby::Deserializer::Document do
  subject(:parsed_document) { JSONAPI::Ruby::Deserializer::Document.new(document) }

  let(:document) { JSON.parse(File.open('spec/fixtures/simple_resource.json').read) }

  context 'document contains multiple resources' do
    it 'checks every feature' do
      expect(parsed_document.data.title).to eq('Lorem Ipsum')
    end
  end
end
