# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::User do
  subject(:response) { Kentaa::Api::Resources::User.new(config, data: data[:user]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/user.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("User_2")
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(2)
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

  describe '#infix' do
    it 'returns the infix' do
      expect(response.infix).to be_nil
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

  describe '#email' do
    it 'returns the email address' do
      expect(response.email).to eq("john.doe@kentaa.nl")
    end
  end

  describe '#avatar_url' do
    it 'returns the avatar url' do
      expect(response.avatar_url).to be_nil
    end
  end

  describe '#address' do
    it 'returns the address' do
      expect(response.address).to eq("Jansbuitensingel 29")
    end
  end

  describe '#address2' do
    it 'returns the address line 2' do
      expect(response.address2).to be_nil
    end
  end

  describe '#street' do
    it 'returns the street' do
      expect(response.street).to eq("Jansbuitensingel")
    end
  end

  describe '#house_number' do
    it 'returns the house number' do
      expect(response.house_number).to eq("29")
    end
  end

  describe '#house_number_addition' do
    it 'returns the house number addition' do
      expect(response.house_number_addition).to be_nil
    end
  end

  describe '#zipcode' do
    it 'returns the zipcode' do
      expect(response.zipcode).to eq("6811AD")
    end
  end

  describe '#city' do
    it 'returns the city' do
      expect(response.city).to eq("Arnhem")
    end
  end

  describe '#country' do
    it 'returns the country' do
      expect(response.country).to eq("NL")
    end
  end

  describe '#phone' do
    it 'returns the phone number' do
      expect(response.phone).to eq("0262616240")
    end
  end

  describe '#birthday' do
    it 'returns the birthday' do
      expect(response.birthday).to be_nil
    end
  end

  describe '#gender' do
    it 'returns the gender' do
      expect(response.gender).to eq("male")
    end
  end

  describe '#locale' do
    it 'returns the locale' do
      expect(response.locale).to eq("nl")
    end
  end

  describe '#consent' do
    it 'returns the associated consent' do
      expect(response.consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(response.consent.url).to eq("https://demo1.kentaa.nl/project/deelnames/meedoen/wie-ben-jij")
      expect(response.consent.text).to eq("Ja, ik geef uitdrukkelijk toestemming voor de verwerking van mijn persoonsgegevens.")
      expect(response.consent.version).to eq("V2 22-06-2018 13:09")
    end
  end

  describe '#consents' do
    it 'returns the associated consents' do
      expect(response.consents).not_to be_empty
      expect(response.consents.count).to eq(2)

      consent = response.consents.first
      expect(consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(consent.consent_type).to eq("terms_conditions")
      expect(consent.consent_status).to eq("granted")
      expect(consent.consent_text).to eq("Ik accepteer de <a href='/algemene-voorwaarden' class='theme-text-color' target='_blank'>Algemene voorwaarden</a>.")
      expect(consent.url).to eq("https://demo1.kentaa.nl/meedoen/wie-ben-jij")
      expect(consent.terms_conditions_version).to eq("V2 22-06-2018 13:09")
    end
  end

  describe '#actions' do
    it 'returns the action resources as a List' do
      expect(response.actions).to be_a(Kentaa::Api::Resources::List)
    end
  end
end
