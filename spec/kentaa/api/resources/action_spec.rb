# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Action do
  subject(:response) { Kentaa::Api::Resources::Action.new(config, data: data[:action]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/action.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('Action_1')
    end
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

  describe '#slug' do
    it 'returns the slug' do
      expect(response.slug).to eq('john-doe')
    end
  end

  describe '#parent' do
    it 'returns the parent resource' do
      expect(response.parent).to be_a(Kentaa::Api::Resources::Team)
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

  describe '#segment_id' do
    it 'returns the segment id' do
      expect(response.segment_id).to eq(2)
    end
  end

  describe '#project_id' do
    it 'returns the project id' do
      expect(response.project_id).to eq(3)
    end
  end

  describe '#team_id' do
    it 'returns the team id' do
      expect(response.team_id).to eq(4)
    end
  end

  describe '#owner' do
    it 'returns the action owner' do
      expect(response.owner).to be_a(Kentaa::Api::Resources::User)
      expect(response.owner.first_name).to eq('John')
      expect(response.owner.last_name).to eq('Doe')
      expect(response.owner.email).to eq('john.doe@kentaa.nl')
    end
  end

  describe '#who_type' do
    it 'returns the who_type' do
      expect(response.who_type).to eq('owner')
    end
  end

  describe '#owner?' do
    it 'returns true when who_type is owner' do
      expect(response.owner?).to be true
    end
  end

  describe '#other?' do
    it 'returns false when who_type is not other' do
      expect(response.other?).to be false
    end
  end

  describe '#first_name' do
    it 'returns the first name' do
      expect(response.first_name).to eq('John')
    end
  end

  describe '#last_name' do
    it 'returns the last name' do
      expect(response.last_name).to eq('Doe')
    end
  end

  describe '#fundraiser_page' do
    it 'returns the fundraiser_page' do
      expect(response.fundraiser_page?).to be true
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq('Lorem ipsum')
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq('Dolorum animi qui nihil iure dolore velit. Rerum eius et quo.')
    end
  end

  describe '#target_amount' do
    it 'returns the target amount' do
      expect(response.target_amount).to eq(1000)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(125.0)
    end
  end

  describe '#total_donations' do
    it 'returns the total donations' do
      expect(response.total_donations).to eq(2)
    end
  end

  describe '#target_amount_achieved?' do
    it 'returns false when target amount not achieved' do
      expect(response.target_amount_achieved?).to be false
    end
  end

  describe '#visible?' do
    it 'returns true when visible' do
      expect(response.visible?).to be true
    end
  end

  describe '#countable?' do
    it 'returns true when countable' do
      expect(response.countable?).to be true
    end
  end

  describe '#closed?' do
    it 'returns false when not closed' do
      expect(response.closed?).to be false
    end
  end

  describe '#ended?' do
    it 'returns false when not ended' do
      expect(response.ended?).to be false
    end
  end

  describe '#end_date' do
    it 'returns the end date' do
      expect(response.end_date).to be_nil
    end
  end

  describe '#external_reference' do
    it 'returns the external reference' do
      expect(response.external_reference).to eq('Customer Campaign 1021AA1-11')
    end
  end

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq('https://demo1.kentaa.nl/actie/john-doe')
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq('https://demo1.kentaa.nl/actie/john-doe/doneren')
    end
  end

  describe '#photos' do
    it 'returns the associated photos' do
      expect(response.photos).not_to be_empty
      expect(response.photos.count).to eq(1)
    end
  end

  describe '#videos' do
    it 'returns the associated videos' do
      expect(response.videos).to be_empty
    end
  end

  describe '#questions' do
    it 'returns the answered questions' do
      expect(response.questions).not_to be_empty
      expect(response.questions.count).to eq(1)
    end
  end

  describe '#consent' do
    it 'returns the associated consent' do
      expect(response.consent).to be_a(Kentaa::Api::Resources::Consent)
      expect(response.consent.url).to eq('https://demo1.kentaa.nl/meedoen/wie-ben-jij')
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

  describe '#performances' do
    describe '#all' do
      it 'returns an enumerator for retrieving all performances' do
        data = File.read('spec/fixtures/responses/performances.json')
        stub_request(:get, 'https://api.kentaa.nl/v1/actions/1/performances?page=1').to_return(status: 200, body: data)

        performances = response.performances.all
        expect(performances).to be_a(Enumerator)
        expect(performances.count).to eq(1)
        expect(performances.first).to be_a(Kentaa::Api::Resources::Performance)
      end
    end

    describe '#each' do
      it 'returns a list of performances' do
        data = File.read('spec/fixtures/responses/performances.json')
        stub_request(:get, 'https://api.kentaa.nl/v1/actions/1/performances').to_return(status: 200, body: data)

        performances = response.performances
        expect(performances).to be_a(Kentaa::Api::Resources::List)
        expect(performances.count).to eq(1)
        expect(performances.total_entries).to eq(1)
        expect(performances.first).to be_a(Kentaa::Api::Resources::Performance)
      end
    end

    describe '#get' do
      it 'returns a single performance' do
        data = File.read('spec/fixtures/responses/performance.json')
        stub_request(:get, 'https://api.kentaa.nl/v1/actions/1/performances/1').to_return(status: 200, body: data)

        performance = response.performances.get(1)
        expect(performance).to be_a(Kentaa::Api::Resources::Performance)
        expect(performance.title).to eq('First tour')
      end

      it 'returns an error when the performance was not found' do
        data = File.read('spec/fixtures/responses/404.json')
        stub_request(:get, 'https://api.kentaa.nl/v1/actions/1/performances/1').to_return(status: 404, body: data)

        expect { response.performances.get(1) }.to raise_error(Kentaa::Api::RequestError, '404: Requested resource was not found.')
      end
    end

    describe '#create' do
      it 'creates a performance' do
        data = File.read('spec/fixtures/responses/performance.json')
        stub_request(:post, 'https://api.kentaa.nl/v1/actions/1/performances').to_return(status: 201, body: data)

        performance = response.performances.create(title: 'First tour', performance_type: 'biking', distance: BigDecimal('65.25'), performance_at: Time.now)
        expect(performance).to be_a(Kentaa::Api::Resources::Performance)
        expect(performance.title).to eq('First tour')
      end
    end

    describe '#update' do
      it 'updates a performance' do
        data = File.read('spec/fixtures/responses/performance.json')
        stub_request(:patch, 'https://api.kentaa.nl/v1/actions/1/performances/1').to_return(status: 200, body: data)

        performance = response.performances.update(1, title: 'First tour')
        expect(performance).to be_a(Kentaa::Api::Resources::Performance)
        expect(performance.title).to eq('First tour')
      end
    end

    describe '#delete' do
      it 'deletes a performance' do
        stub_request(:delete, 'https://api.kentaa.nl/v1/actions/1/performances/1').to_return(status: 204)

        performance = response.performances.delete(1)
        expect(performance).to be_nil
      end
    end
  end
end
