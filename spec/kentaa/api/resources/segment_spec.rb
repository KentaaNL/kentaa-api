# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::Segment do
  subject(:response) { Kentaa::Api::Resources::Segment.new(config, data: data[:segment]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/segment.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("Segment_12")
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(12)
    end
  end

  describe '#parent' do
    it 'returns the parent resource' do
      expect(response.parent).to be_a(Kentaa::Api::Resources::Site)
    end
  end

  describe '#site' do
    it 'returns the site resource' do
      expect(response.site).to be_a(Kentaa::Api::Resources::Site)
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
      expect(response.end_date).to be_nil
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

  describe '#external_reference' do
    it 'returns the external reference' do
      expect(response.external_reference).to eq("Customer Campaign 1021AA1-11")
    end
  end

  describe '#actions' do
    it 'returns the action resources as a List' do
      expect(response.actions).to be_a(Kentaa::Api::Resources::List)
    end
  end

  describe '#teams' do
    it 'returns the team resources as a List' do
      expect(response.teams).to be_a(Kentaa::Api::Resources::List)
    end
  end

  describe '#projects' do
    it 'returns the project resources as a List' do
      expect(response.projects).to be_a(Kentaa::Api::Resources::List)
    end
  end

  describe '#donations' do
    it 'returns the donation resources as a List' do
      expect(response.donations).to be_a(Kentaa::Api::Resources::List)
    end
  end

  describe '#manual_donations' do
    it 'returns the manual donation resources as a List' do
      expect(response.manual_donations).to be_a(Kentaa::Api::Resources::List)
    end
  end

  describe '#newsletter_subscriptions' do
    it 'returns the newsletter subscription resources as a List' do
      expect(response.newsletter_subscriptions).to be_a(Kentaa::Api::Resources::List)
    end
  end
end
