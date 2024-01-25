# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Avatar do
  subject(:response) { described_class.new(config, data: data[:avatar]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/avatar.json'), symbolize_names: true) }

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#created_at' do
    it 'returns the created_at timestamp' do
      expect(response.created_at).to be_a(Time)
    end
  end

  describe '#updated_at' do
    it 'returns the updated_at timestamp' do
      expect(response.updated_at).to be_a(Time)
    end
  end

  describe '#avatar_url' do
    it 'returns the avatar URL' do
      expect(response.avatar_url).to eq('https://cdn.kentaa.nl/avatars/avatar/1/thumb_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg')
    end
  end
end
