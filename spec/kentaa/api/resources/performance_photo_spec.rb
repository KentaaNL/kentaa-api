# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::PerformancePhoto do
  subject(:response) { Kentaa::Api::Resources::PerformancePhoto.new(config, data: data[:photo]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/performance_photo.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("ActionPerformancePhoto_1")
    end
  end

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

  describe '#image_url' do
    it 'returns the image URL' do
      expect(response.image_url).to eq("https://d2a3ux41sjxpco.cloudfront.net/action_performance_photos/file/1/normal_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg")
    end
  end
end
