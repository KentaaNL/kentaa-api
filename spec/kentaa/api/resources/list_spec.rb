# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::List do
  subject(:response) { Kentaa::Api::Resources::Actions.new(config) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }

  before do
    data = File.read("spec/fixtures/responses/actions.json")
    stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 200, body: data)
  end

  describe '#links' do
    it 'returns a hash with links' do
      expect(response.links).to be_a(Hash)
      expect(response.links).to include(:pages)
    end
  end

  describe '#pages' do
    it 'returns a hash with pages' do
      expect(response.pages).to be_a(Hash)
      expect(response.pages).to include(:next)
      expect(response.pages).to include(:last)
    end
  end

  describe '#total_entries' do
    it 'returns the total number of entries' do
      expect(response.total_entries).to eq(34)
    end
  end

  describe '#total_pages' do
    it 'returns the total number of pages' do
      expect(response.total_pages).to eq(17)
    end
  end

  describe '#per_page' do
    it 'returns the number per page' do
      expect(response.per_page).to eq(2)
    end
  end

  describe '#current_page' do
    it 'returns the current page' do
      expect(response.current_page).to eq(1)
    end
  end

  describe '#next_page' do
    it 'returns the next page' do
      expect(response.next_page).to eq(2)
    end
  end

  describe '#next_page?' do
    it 'returns true when a next page is present' do
      expect(response.next_page?).to be true
    end
  end

  describe '#previous_page' do
    it 'returns the previous page' do
      expect(response.previous_page).to be nil
    end
  end

  describe '#previous_page?' do
    it 'returns true when a previous page is present' do
      expect(response.previous_page?).to be false
    end
  end
end
