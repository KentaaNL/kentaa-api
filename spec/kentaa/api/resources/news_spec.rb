# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::News do
  subject(:response) { described_class.new(config, data: data[:news]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/news.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('News_1')
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#public_id' do
    it 'returns the public id' do
      expect(response.public_id).to eq('M1QEoRgvmCoS')
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

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq('Example News Item')
    end
  end

  describe '#content' do
    it 'returns the content' do
      expect(response.content).to eq('<p class="">This is the content of a news item</p>')
    end
  end

  describe '#publish_state' do
    it 'returns the publish state' do
      expect(response.publish_state).to eq('published')
    end
  end

  describe '#publish_at' do
    it 'returns the publish_at timestamp' do
      expect(response.publish_at).to be_a(Time)
    end
  end

  describe '#labels' do
    it 'returns the labels' do
      expect(response.labels).to eq(%w[my-label my-other-label])
    end
  end

  describe '#photos' do
    it 'returns the associated photos' do
      expect(response.photos).not_to be_empty
      expect(response.photos.count).to eq(1)

      photo = response.photos.first
      expect(photo).to be_a(Kentaa::Api::Resources::Photo)
      expect(photo.id).to eq(2)
    end
  end

  describe '#videos' do
    it 'returns the associated videos' do
      expect(response.videos).not_to be_empty
      expect(response.videos.count).to eq(1)

      video = response.videos.first
      expect(video).to be_a(Kentaa::Api::Resources::Video)
      expect(video.id).to eq(3)
    end
  end
end
