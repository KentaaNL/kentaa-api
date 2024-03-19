# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Activity do
  subject(:response) { described_class.new(config, data: data[:activity]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/activity.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('Activity_1')
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

  describe '#site' do
    it 'returns the site resource' do
      expect(response.site).to be_a(Kentaa::Api::Resources::Site)
    end
  end

  describe '#site_id' do
    it 'returns the site id' do
      expect(response.site_id).to eq(1)
    end
  end

  describe '#name' do
    it 'returns the name' do
      expect(response.name).to eq('Walking')
    end
  end

  describe '#sign_up_limit' do
    it 'returns the sign up limit' do
      expect(response.sign_up_limit).to eq(50)
    end
  end

  describe '#sign_up_count' do
    it 'returns the sign up count' do
      expect(response.sign_up_count).to eq(0)
    end
  end
end
