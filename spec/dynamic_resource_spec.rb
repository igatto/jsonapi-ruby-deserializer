# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'

describe JSONAPI::Ruby::Deserializer::Document do
  subject(:document) { JSONAPI::Ruby::Deserializer::Document.new(json) }

  let(:json) { JSON.parse(File.open('spec/fixtures/singular_resource.json').read) }

  context 'document contains singular resource' do
    before do
      document.data.attributes.dynamic_key = 'dynamic_value'
    end

    it 'checks every feature' do
      expect(document.data.attributes.dynamic_key).to eq('dynamic_value')
      expect(document.data.attributes.to_h).to eq({'dynamic_key' => 'dynamic_value', 'title'=>'JSON:API paints my bikeshed!'})
    end
  end
end
