# frozen_string_literal: true

require "spec_helper"

describe Kentaa::Api::Config do
  subject(:config) { Kentaa::Api::Config.new(api_key, options) }

  let(:api_key) { "12345" }
  let(:options) { {} }

  describe '#api_url' do
    context 'when default' do
      it 'returns the production API URL' do
        expect(config.api_url).to eq("https://api.kentaa.nl/v1")
      end
    end

    context 'when test mode enabled' do
      let(:options) { { test: true } }

      it 'returns the test API URL' do
        expect(config.api_url).to eq("https://api.kentaa.staatklaar.nu/v1")
      end
    end

    context 'when dev mode enabled' do
      let(:options) { { dev: true } }

      it 'returns the development API URL' do
        expect(config.api_url).to eq("http://api.lvh.me:3000/v1")
      end
    end
  end
end
