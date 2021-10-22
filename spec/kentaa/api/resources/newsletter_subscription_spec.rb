# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::NewsletterSubscription do
  subject(:response) { Kentaa::Api::Resources::NewsletterSubscription.new(config, data: data[:newsletter_subscription]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/newsletter_subscription.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("NewsletterSubscription_1")
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#entity' do
    it 'returns the entity resource' do
      expect(response.entity).to be_a(Kentaa::Api::Resources::Site)
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

  describe '#first_name' do
    it 'returns the first name' do
      expect(response.first_name).to eq("John")
    end
  end

  describe '#last_name' do
    it 'returns the email address' do
      expect(response.last_name).to eq("Doe")
    end
  end

  describe '#email' do
    it 'returns the email address' do
      expect(response.email).to eq("john.doe@kentaa.nl")
    end
  end

  describe '#locale' do
    it 'returns the email address' do
      expect(response.locale).to eq("nl")
    end
  end

  describe '#subscription_url' do
    it 'returns the subscription URL' do
      expect(response.subscription_url).to eq("https://demo1.kentaa.nl")
    end
  end

  describe '#consent' do
    it 'returns the associated consent' do
      expect(response.consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(response.consent.url).to eq("https://demo1.kentaa.nl")
      expect(response.consent.text).to eq("Ja, ik wil de nieuwsbrief ontvangen")
      expect(response.consent.version).to eq("V2 22-06-2018 13:09")
    end
  end

  describe '#consents' do
    it 'returns the associated consents' do
      expect(response.consents).not_to be_empty
      expect(response.consents.count).to eq(1)

      consent = response.consents.first
      expect(consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(consent.consent_type).to eq("newsletter_subscription")
      expect(consent.consent_status).to eq("granted")
      expect(consent.consent_text).to eq("Ja, ik wil de nieuwsbrief ontvangen")
      expect(consent.url).to eq("https://demo1.kentaa.nl")
      expect(consent.terms_conditions_version).to eq("V2 22-06-2018 13:09")
    end
  end
end
