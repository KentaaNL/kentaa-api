# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::ManualDonation do
  subject(:response) { described_class.new(config, data: data[:manual_donation]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/manual_donation.json'), symbolize_names: true) }

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

  describe '#public_id' do
    it 'returns the public id' do
      expect(response.public_id).to eq('ejA4d4sQ1MJK')
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
      expect(response.site_id).to eq(1)
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

  describe '#company_id' do
    it 'returns the company id' do
      expect(response.company_id).to be_nil
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
      expect(response.infix).to eq('')
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

  describe '#amount' do
    it 'returns the donation amount' do
      expect(response.amount).to eq(100.0)
    end
  end

  describe '#target_url' do
    it 'returns the target URL' do
      expect(response.target_url).to eq('https://demo1.kentaa.nl/')
    end
  end
end
