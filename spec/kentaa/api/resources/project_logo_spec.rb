# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::ProjectLogo do
  subject(:response) { described_class.new(config, data: data[:logo]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/project_logo.json'), symbolize_names: true) }

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

  describe '#logo_url' do
    it 'returns the logo URL' do
      expect(response.logo_url).to eq('https://cdn.kentaa.nl/project_logos/logo/project_logo/1/ad28ec6c324df46cf5b3435133d4aed6362c1c22.png')
    end
  end
end
