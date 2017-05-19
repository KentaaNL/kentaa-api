require "spec_helper"

describe Kentaa::Api::Responses::NewsletterSubscription do
  subject(:response) do
    data = JSON.parse(File.read("spec/fixtures/responses/newsletter_subscriptions.json"), symbolize_names: true)
    Kentaa::Api::Responses::NewsletterSubscription.new(data[:newsletter_subscriptions].first)
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
