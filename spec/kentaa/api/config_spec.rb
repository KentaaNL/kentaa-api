# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Config do
  subject(:config) { Kentaa::Api::Config.new(options) }

  let(:options) { { api_key: "12345" } }

  describe '#api_key' do
    it 'returns the provided API key' do
      expect(config.api_key).to eq("12345")
    end
  end

  describe '#environment' do
    context 'when default' do
      it 'returns the default environment' do
        expect(config.environment).to eq(:live)
      end
    end

    context 'when test mode enabled' do
      let(:options) { { test: true } }

      it 'returns the test environment' do
        expect(config.environment).to eq(:test)
      end
    end

    context 'when dev mode enabled' do
      let(:options) { { dev: true } }

      it 'returns the development environment' do
        expect(config.environment).to eq(:development)
      end
    end
  end

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

  describe '#debug?' do
    context 'when default' do
      it 'returns false' do
        expect(config.debug?).to be false
      end
    end

    context 'when debug mode enabled' do
      let(:options) { { debug: true } }

      it 'returns true' do
        expect(config.debug?).to be true
      end
    end

    context 'when debug mode disabled' do
      let(:options) { { debug: false } }

      it 'returns false' do
        expect(config.debug?).to be false
      end
    end
  end
end
