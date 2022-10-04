# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Donation do
  subject(:response) { described_class.new(config, data: data[:donation]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/donation.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('Donation_1')
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

  describe '#recurring_donor' do
    it 'returns the recurring donor when present' do
      expect(response.recurring_donor).to be_nil
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

  describe '#donation_form_id' do
    it 'returns the donation form id' do
      expect(response.donation_form_id).to be_nil
    end
  end

  describe '#segment_id' do
    it 'returns the segment id' do
      expect(response.segment_id).to be_nil
    end
  end

  describe '#project_id' do
    it 'returns the project id' do
      expect(response.project_id).to be_nil
    end
  end

  describe '#team_id' do
    it 'returns the team id' do
      expect(response.team_id).to be_nil
    end
  end

  describe '#action_id' do
    it 'returns the action id' do
      expect(response.action_id).to be_nil
    end
  end

  describe '#recurring_donor_id' do
    it 'returns the recurring donor id' do
      expect(response.recurring_donor_id).to be_nil
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
      expect(response.first_name).to eq('John')
    end
  end

  describe '#infix' do
    it 'returns the infix' do
      expect(response.infix).to be_nil
    end
  end

  describe '#last_name' do
    it 'returns the last name' do
      expect(response.last_name).to eq('Doe')
    end
  end

  describe '#name' do
    it 'returns the full name' do
      expect(response.name).to eq('John Doe')
    end
  end

  describe '#company' do
    it 'returns the company name' do
      expect(response.company).to be_nil
    end
  end

  describe '#anonymous?' do
    it 'returns true when anonymous' do
      expect(response.anonymous?).to be false
    end
  end

  describe '#email' do
    it 'returns the email address' do
      expect(response.email).to eq('john.doe@kentaa.nl')
    end
  end

  describe '#newsletter?' do
    it 'returns true when subscribed to newsletter' do
      expect(response.newsletter?).to be false
    end
  end

  describe '#device_type' do
    it 'returns the device type' do
      expect(response.device_type).to eq('desktop')
    end
  end

  describe '#locale' do
    it 'returns the locale' do
      expect(response.locale).to eq('nl')
    end
  end

  describe '#frequency_type' do
    it 'returns the frequency type' do
      expect(response.frequency_type).to eq('oneoff')
    end
  end

  describe '#currency' do
    it 'returns the donation currency' do
      expect(response.currency).to eq('EUR')
    end
  end

  describe '#amount' do
    it 'returns the donation amount' do
      expect(response.amount).to eq(15.0)
    end
  end

  describe '#transaction_costs' do
    it 'returns the transaction costs' do
      expect(response.transaction_costs).to eq(0.4)
    end
  end

  describe '#start_donation?' do
    it 'returns false when this is not a start donation' do
      expect(response.start_donation?).to be false
    end
  end

  describe '#registration_fee?' do
    it 'returns true when a registration fee was paid' do
      expect(response.registration_fee?).to be true
    end
  end

  describe '#registration_fee_amount' do
    it 'returns the registration fee amount' do
      expect(response.registration_fee_amount).to eq(10.0)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(25.4)
    end
  end

  describe '#receivable_amount' do
    it 'returns the receivable amount' do
      expect(response.receivable_amount).to eq(24)
    end
  end

  describe '#invoicenumber' do
    it 'returns the invoice number' do
      expect(response.invoicenumber).to eq('T2016.0001.0000001')
    end
  end

  describe '#payment_method' do
    it 'returns the payment method' do
      expect(response.payment_method).to eq('ideal')
    end
  end

  describe '#payment_status' do
    it 'returns the payment status' do
      expect(response.payment_status).to eq('paid')
    end
  end

  describe '#payment_status_at' do
    it 'returns the payment status update timestamp' do
      expect(response.payment_status_at).to be_a(Time)
    end
  end

  describe '#transaction_id' do
    it 'returns the PSP transaction ID' do
      expect(response.transaction_id).to eq('B5C7B7BCAF1ADF6E2032C7CF56969876')
    end
  end

  describe '#payment_id' do
    it 'returns the PSP payment ID' do
      expect(response.payment_id).to eq('116D10DD544ECD1E2D77762C5C3E6D61')
    end
  end

  describe '#payment_description' do
    it 'returns the payment description' do
      expect(response.payment_description).to eq('Donatie Demo')
    end
  end

  describe '#target_url' do
    it 'returns the target URL' do
      expect(response.target_url).to eq('https://demo1.kentaa.nl/')
    end
  end

  describe '#reward' do
    it 'returns the associated reward' do
      expect(response.reward).to be_a(Kentaa::Api::Resources::Reward)
      expect(response.reward.type).to eq('SiteReward')
      expect(response.reward.title).to eq('Awesome reward')
      expect(response.reward.description).to eq('Lorem ipsum')
      expect(response.reward.ask_for_address?).to be true
    end
  end

  describe '#address' do
    it 'returns the associated address' do
      expect(response.address).to be_a(Kentaa::Api::Resources::Address)
      expect(response.address.address).to eq('Jansbuitensingel 29')
      expect(response.address.street).to eq('Jansbuitensingel')
      expect(response.address.house_number).to eq('29')
      expect(response.address.zipcode).to eq('6811AD')
      expect(response.address.city).to eq('Arnhem')
      expect(response.address.country).to eq('NL')
    end
  end

  describe '#consent' do
    it 'returns the associated consent' do
      expect(response.consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(response.consent.url).to eq('https://demo1.kentaa.nl/doneren')
      expect(response.consent.text).to eq("Ik accepteer de <a href='/algemene-voorwaarden' class='theme-text-color' target='_blank'>Algemene voorwaarden</a>.")
      expect(response.consent.version).to eq('V2 22-06-2018 13:09')
    end
  end

  describe '#consents' do
    it 'returns the associated consents' do
      expect(response.consents).not_to be_empty
      expect(response.consents.count).to eq(1)

      consent = response.consents.first
      expect(consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(consent.consent_type).to eq('terms_conditions')
      expect(consent.consent_status).to eq('granted')
      expect(consent.consent_text).to eq("Ik accepteer de <a href='/algemene-voorwaarden' class='theme-text-color' target='_blank'>Algemene voorwaarden</a>.")
      expect(consent.url).to eq('https://demo1.kentaa.nl/doneren')
      expect(consent.terms_conditions_version).to eq('V2 22-06-2018 13:09')
      expect(consent.privacy_version).to eq('V1 10-06-2018 11:42')
    end
  end
end
