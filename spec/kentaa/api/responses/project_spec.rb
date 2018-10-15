# frozen_string_literal: true

require "spec_helper"

describe Kentaa::Api::Responses::Project do
  subject(:response) do
    data = JSON.parse(File.read("spec/fixtures/responses/project.json"), symbolize_names: true)
    Kentaa::Api::Responses::Project.new(data)
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#segment_id' do
    it 'returns the segment id' do
      expect(response.segment_id).to eq(2)
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

  describe '#slug' do
    it 'returns the slug' do
      expect(response.slug).to eq("dignissimos-provident")
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq("Dignissimos provident rerum enim alias magni asperna...")
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq("Fugiat et nulla mollitia. Ut omnis adipisci et. Consequatur voluptatibus est dicta rem.")
    end
  end

  describe '#target_amount' do
    it 'returns the target amount' do
      expect(response.target_amount).to eq(250_000)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(1250.0)
    end
  end

  describe '#total_donations' do
    it 'returns the total donations' do
      expect(response.total_donations).to eq(18)
    end
  end

  describe '#visible?' do
    it 'returns true when visible' do
      expect(response.visible?).to be true
    end
  end

  describe '#end_date' do
    it 'returns the end date' do
      expect(response.end_date).to be_a(Time)
    end
  end

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq("https://demo1.kentaa.nl/project/dignissimos-provident-rerum-enim-alias-magni-asperna")
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq("https://demo1.kentaa.nl/project/dignissimos-provident-rerum-enim-alias-magni-asperna/doneren")
    end
  end
end
