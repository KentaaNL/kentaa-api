# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::User do
  subject(:response) { described_class.new(config, data: data[:user]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/user.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('User_2')
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

  describe '#email' do
    it 'returns the email address' do
      expect(response.email).to eq('john.doe@kentaa.nl')
    end
  end

  describe '#avatar_url' do
    it 'returns the avatar url' do
      expect(response.avatar_url).to be_nil
    end
  end

  describe '#address' do
    it 'returns the address' do
      expect(response.address).to eq('Jansbuitensingel 29')
    end
  end

  describe '#address2' do
    it 'returns the address line 2' do
      expect(response.address2).to be_nil
    end
  end

  describe '#street' do
    it 'returns the street' do
      expect(response.street).to eq('Jansbuitensingel')
    end
  end

  describe '#house_number' do
    it 'returns the house number' do
      expect(response.house_number).to eq('29')
    end
  end

  describe '#house_number_addition' do
    it 'returns the house number addition' do
      expect(response.house_number_addition).to be_nil
    end
  end

  describe '#zipcode' do
    it 'returns the zipcode' do
      expect(response.zipcode).to eq('6811AD')
    end
  end

  describe '#city' do
    it 'returns the city' do
      expect(response.city).to eq('Arnhem')
    end
  end

  describe '#country' do
    it 'returns the country' do
      expect(response.country).to eq('NL')
    end
  end

  describe '#phone' do
    it 'returns the phone number' do
      expect(response.phone).to eq('0262616240')
    end
  end

  describe '#birthday' do
    it 'returns the birthday' do
      expect(response.birthday).to be_nil
    end
  end

  describe '#gender' do
    it 'returns the gender' do
      expect(response.gender).to eq('male')
    end
  end

  describe '#locale' do
    it 'returns the locale' do
      expect(response.locale).to eq('nl')
    end
  end

  describe '#consent' do
    it 'returns the associated consent' do
      expect(response.consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(response.consent.url).to eq('https://demo1.kentaa.nl/project/deelnames/meedoen/wie-ben-jij')
      expect(response.consent.text).to eq('Ja, ik geef uitdrukkelijk toestemming voor de verwerking van mijn persoonsgegevens.')
      expect(response.consent.version).to eq('V2 22-06-2018 13:09')
    end
  end

  describe '#consents' do
    it 'returns the associated consents' do
      expect(response.consents).not_to be_empty
      expect(response.consents.count).to eq(2)

      consent = response.consents.first
      expect(consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(consent.consent_type).to eq('terms_conditions')
      expect(consent.consent_status).to eq('granted')
      expect(consent.consent_text).to eq("Ik accepteer de <a href='/algemene-voorwaarden' class='theme-text-color' target='_blank'>Algemene voorwaarden</a>.")
      expect(consent.url).to eq('https://demo1.kentaa.nl/meedoen/wie-ben-jij')
      expect(consent.terms_conditions_version).to eq('V2 22-06-2018 13:09')
      expect(consent.privacy_version).to eq('V1 10-06-2018 11:42')
    end
  end

  describe '#actions' do
    it 'returns the action resources as a List' do
      expect(response.actions).to be_a(Kentaa::Api::Resources::List)
    end
  end

  describe '#avatar' do
    describe '#load' do
      context 'when the avatar is present' do
        before do
          data = File.read('spec/fixtures/responses/avatar.json')
          stub_request(:get, 'https://api.kentaa.nl/v1/users/2/avatar').to_return(status: 200, body: data)
        end

        it 'returns the associated avatar' do
          expect(response.avatar).to be_a(Kentaa::Api::Resources::Avatar)
          expect(response.avatar.avatar_url).to eq('https://cdn.kentaa.nl/avatars/avatar/1/thumb_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg')
        end
      end

      context 'when the avatar is absent' do
        before do
          data = File.read('spec/fixtures/responses/404.json')
          stub_request(:get, 'https://api.kentaa.nl/v1/users/2/avatar').to_return(status: 404, body: data)
        end

        it 'returns an error' do
          expect { response.avatar.load }.to raise_error(Kentaa::Api::RequestError, '404: Requested resource was not found.')
        end
      end
    end

    describe '#create' do
      it 'creates an avatar' do
        data = File.read('spec/fixtures/responses/avatar.json')
        stub_request(:post, 'https://api.kentaa.nl/v1/users/2/avatar').to_return(status: 201, body: data)

        avatar = response.avatar.create(io: File.open('spec/fixtures/test.jpg'), content_type: 'image/jpeg')
        expect(avatar).to be_a(Kentaa::Api::Resources::Avatar)
        expect(avatar.avatar_url).to eq('https://cdn.kentaa.nl/avatars/avatar/1/thumb_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg')
      end
    end

    describe '#delete' do
      it 'deletes a performance' do
        request = stub_request(:delete, 'https://api.kentaa.nl/v1/users/2/avatar').to_return(status: 204)

        avatar = response.avatar.delete
        expect(avatar).to be_nil

        expect(request).to have_been_requested
      end
    end
  end
end
