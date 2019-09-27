# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::Action do
  subject(:response) { Kentaa::Api::Resources::Action.new(config, data: data[:action]) }

  let(:config) { Kentaa::Api::Config.new("12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/action.json"), symbolize_names: true) }

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

  describe '#slug' do
    it 'returns the slug' do
      expect(response.slug).to eq("john-doe")
    end
  end

  describe '#site_id' do
    it 'returns the site id' do
      expect(response.site_id).to eq(6)
    end
  end

  describe '#segment_id' do
    it 'returns the segment id' do
      expect(response.segment_id).to eq(2)
    end
  end

  describe '#project_id' do
    it 'returns the project id' do
      expect(response.project_id).to eq(3)
    end
  end

  describe '#team_id' do
    it 'returns the team id' do
      expect(response.team_id).to eq(4)
    end
  end

  describe '#owner' do
    it 'returns the action owner' do
      expect(response.owner).to be_a(Kentaa::Api::Resources::User)
      expect(response.owner.first_name).to eq("John")
      expect(response.owner.last_name).to eq("Doe")
      expect(response.owner.email).to eq("john.doe@kentaa.nl")
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq("Lorem ipsum")
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq("Dolorum animi qui nihil iure dolore velit. Rerum eius et quo.")
    end
  end

  describe '#target_amount' do
    it 'returns the target amount' do
      expect(response.target_amount).to eq(1000)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(125.0)
    end
  end

  describe '#total_donations' do
    it 'returns the total donations' do
      expect(response.total_donations).to eq(2)
    end
  end

  describe '#visible?' do
    it 'returns true when visible' do
      expect(response.visible?).to be true
    end
  end

  describe '#end_date' do
    it 'returns the end date' do
      expect(response.end_date).to be nil
    end
  end

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq("https://demo1.kentaa.nl/actie/john-doe")
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq("https://demo1.kentaa.nl/actie/john-doe/doneren")
    end
  end

  describe '#photos' do
    it 'returns the associated photos' do
      expect(response.photos).not_to be_empty
      expect(response.photos.count).to eq(1)
    end
  end

  describe '#videos' do
    it 'returns the associated videos' do
      expect(response.videos).to be_empty
    end
  end

  describe '#questions' do
    it 'returns the answered questions' do
      expect(response.questions).not_to be_empty
      expect(response.questions.count).to eq(1)
    end
  end
end
