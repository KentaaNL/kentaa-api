# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::NewsletterSubscription do
  subject(:response) do
    data = JSON.parse(File.read("spec/fixtures/responses/newsletter_subscription.json"), symbolize_names: true)
    Kentaa::Api::Resources::NewsletterSubscription.new(config, data[:newsletter_subscription])
  end

  let(:config) { Kentaa::Api::Config.new("12345") }

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
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
end
