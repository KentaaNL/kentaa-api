# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::Site do
  subject(:response) { Kentaa::Api::Resources::Site.new(config, data: data[:site]) }

  let(:config) { Kentaa::Api::Config.new("12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/site.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("Site_6")
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(6)
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
      expect(response.target_amount).to eq(5000)
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
      expect(response.url).to eq("https://demo1.kentaa.nl/")
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq("https://demo1.kentaa.nl/doneren")
    end
  end

  describe '#video_url' do
    it 'returns the video URL' do
      expect(response.video_url).to eq("https://www.youtube.com/watch?v=VLv1jKC39jGQk")
    end
  end

  describe '#owner_name' do
    it 'returns the owner name' do
      expect(response.owner_name).to eq("John doe")
    end
  end

  describe '#owner_email' do
    it 'returns the owner email' do
      expect(response.owner_email).to eq("johndoe@example.com")
    end
  end

  describe '#banners' do
    it 'returns the associated banners' do
      expect(response.banners).not_to be_empty
      expect(response.banners.count).to eq(1)
    end
  end

  describe '#external_reference' do
    it 'returns the external reference' do
      expect(response.external_reference).to be nil
    end
  end

  describe '#donations' do
    it 'returns the donations resource' do
      expect(response.donations).to be_a(Kentaa::Api::Resources::Donations)
    end
  end

  describe '#manual_donations' do
    it 'returns the manual donations resource' do
      expect(response.manual_donations).to be_a(Kentaa::Api::Resources::ManualDonations)
    end
  end

  describe '#newsletter_subscriptions' do
    it 'returns the newsletter subscriptions resource' do
      expect(response.newsletter_subscriptions).to be_a(Kentaa::Api::Resources::NewsletterSubscriptions)
    end
  end
end
