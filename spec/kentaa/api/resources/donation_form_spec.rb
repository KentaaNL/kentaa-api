# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::DonationForm do
  subject(:response) { Kentaa::Api::Resources::DonationForm.new(config, data: data[:donation_form]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/donation_form.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("DonationForm_1")
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
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
      expect(response.site_id).to eq(1)
    end
  end

  describe '#slug' do
    it 'returns the slug' do
      expect(response.slug).to eq("form")
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

  describe '#owner' do
    it 'returns the donation form owner' do
      expect(response.owner).to be_a(Kentaa::Api::Resources::User)
      expect(response.owner.first_name).to eq("John")
      expect(response.owner.last_name).to eq("Doe")
      expect(response.owner.email).to eq("john.doe@kentaa.nl")
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq("Lorem ipsum dolor sit amet")
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(95.0)
    end
  end

  describe '#total_donations' do
    it 'returns the total donations' do
      expect(response.total_donations).to eq(4)
    end
  end

  describe '#published?' do
    it 'returns true when published' do
      expect(response.published?).to be true
    end
  end

  describe '#visible?' do
    it 'returns true when visible' do
      expect(response.visible?).to be true
    end
  end

  describe '#external_reference' do
    it 'returns the external reference' do
      expect(response.external_reference).to be nil
    end
  end

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq("https://demo1.kentaa.nl/form")
    end
  end

  describe '#banners' do
    it 'returns the associated banners' do
      expect(response.banners).to be_empty
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

  describe '#recurring_donors' do
    it 'returns the recurring donor resources as a List' do
      expect(response.recurring_donors).to be_a(Kentaa::Api::Resources::List)
    end
  end
end
