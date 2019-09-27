# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::Segment do
  subject(:response) { Kentaa::Api::Resources::Segment.new(config, data: data[:segment]) }

  let(:config) { Kentaa::Api::Config.new("12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/segment.json"), symbolize_names: true) }

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(12)
    end
  end

  describe '#site_id' do
    it 'returns the site id' do
      expect(response.site_id).to eq(6)
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

  describe '#subdomain' do
    it 'returns the subdomain' do
      expect(response.subdomain).to eq("segment-2")
    end
  end

  describe '#name' do
    it 'returns the name' do
      expect(response.name).to eq("Segment 2")
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq("Aut est maxime nostrum.")
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq("Maiores ut velit fugiat eos. Quae est nostrum rerum aut et nihil. Sequi eveniet occaecati et est corporis et enim.")
    end
  end

  describe '#target_amount' do
    it 'returns the target amount' do
      expect(response.target_amount).to eq(2685)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(0.0)
    end
  end

  describe '#total_donations' do
    it 'returns the total donations' do
      expect(response.total_donations).to eq(0)
    end
  end

  describe '#end_date' do
    it 'returns the end date' do
      expect(response.end_date).to be nil
    end
  end

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq("https://segment-2.demo1.kentaa.nl/")
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq("https://segment-2.demo1.kentaa.nl/doneren")
    end
  end

  describe '#banners' do
    it 'returns the associated banners' do
      expect(response.banners).not_to be_empty
      expect(response.banners.count).to eq(1)
    end
  end
end
