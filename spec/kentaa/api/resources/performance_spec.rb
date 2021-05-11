# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::Performance do
  subject(:response) { Kentaa::Api::Resources::Performance.new(config, data: data[:performance]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/performance.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("ActionPerformance_1")
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#action' do
    it 'returns the action resource' do
      expect(response.action).to be_a(Kentaa::Api::Resources::Action)
    end
  end

  describe '#action_id' do
    it 'returns the action id' do
      expect(response.action_id).to eq(1)
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
      expect(response.title).to eq("First tour")
    end
  end

  describe '#performance_type' do
    it 'returns the performance_type' do
      expect(response.performance_type).to eq("biking")
    end
  end

  describe '#performance_at' do
    it 'returns the performance_at timestamp' do
      expect(response.performance_at).to be_a(Time)
    end
  end

  describe '#distance' do
    it 'returns the distance' do
      expect(response.distance).to eq(65.25)
    end
  end

  describe '#unit' do
    it 'returns the unit' do
      expect(response.unit).to eq("km")
    end
  end
end
