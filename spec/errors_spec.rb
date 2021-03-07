# frozen_string_literal: true

require 'jsonapi-ruby-deserializer'
require 'json'

describe JSONAPI::Ruby::Deserializer::Document do
  subject(:parsed_document) { JSONAPI::Ruby::Deserializer::Document.new(document) }

  let(:document) { JSON.parse(File.open('spec/fixtures/errors.json').read) }

  context 'document contains key errors' do
    it 'checks every feature' do
      expect(parsed_document.errors[0].detail).to eq('First name must contain at least three characters.')
    end
  end
end
