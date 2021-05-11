# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::RecurringDonor do
  subject(:response) { Kentaa::Api::Resources::RecurringDonor.new(config, data: data[:recurring_donor]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/recurring_donor.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("RecurringDonor_1")
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#entity' do
    it 'returns the entity resource' do
      expect(response.entity).to be_a(Kentaa::Api::Resources::DonationForm)
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

  describe '#infix' do
    it 'returns the infix' do
      expect(response.infix).to eq("")
    end
  end

  describe '#last_name' do
    it 'returns the last name' do
      expect(response.last_name).to eq("Doe")
    end
  end

  describe '#name' do
    it 'returns the full name' do
      expect(response.name).to eq("John Doe")
    end
  end

  describe '#company' do
    it 'returns the company name' do
      expect(response.company).to be nil
    end
  end

  describe '#anonymous?' do
    it 'returns false if not anonymous' do
      expect(response.anonymous?).to be false
    end
  end

  describe '#email' do
    it 'returns the email address' do
      expect(response.email).to eq("john.doe@kentaa.nl")
    end
  end

  describe '#locale' do
    it 'returns the locale' do
      expect(response.locale).to eq("nl")
    end
  end

  describe '#frequency_type' do
    it 'returns the frequency type' do
      expect(response.frequency_type).to eq("monthly")
    end
  end

  describe '#start_date' do
    it 'returns the start date' do
      expect(response.start_date).to be_a(Date)
      expect(response.start_date.iso8601).to eq("2020-10-01")
    end
  end

  describe '#end_date' do
    it 'returns the end date' do
      expect(response.end_date).to be nil
    end
  end

  describe '#active?' do
    it 'returns true if active' do
      expect(response.active?).to be true
    end
  end

  describe '#currency' do
    it 'returns the donation currency' do
      expect(response.currency).to eq("EUR")
    end
  end

  describe '#amount' do
    it 'returns the donation amount' do
      expect(response.amount).to eq(50.0)
    end
  end

  describe '#transaction_costs' do
    it 'returns the transaction costs' do
      expect(response.transaction_costs).to eq(0.4)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(50.4)
    end
  end

  describe '#donations' do
    it 'returns the donations resource' do
      expect(response.donations).to be_a(Kentaa::Api::Resources::Donations)
    end
  end
end
