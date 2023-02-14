# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Order do
  subject(:response) { described_class.new(config, data: data[:order]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/order.json'), symbolize_names: true) }

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
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

  describe '#action_id' do
    it 'returns the action id' do
      expect(response.action_id).to eq(1)
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

  describe '#currency' do
    it 'returns the order currency' do
      expect(response.currency).to eq('EUR')
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(65.0)
    end
  end

  describe '#invoicenumber' do
    it 'returns the invoice number' do
      expect(response.invoicenumber).to eq('T2021.0004.0000001')
    end
  end

  describe '#payment_status' do
    it 'returns the payment status' do
      expect(response.payment_status).to eq('paid')
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

  describe '#items' do
    it 'returns the associated items' do
      expect(response.items).not_to be_empty
      expect(response.items.size).to eq(2)

      expect(response.items.first.product).to be_a(Kentaa::Api::Resources::Product)
      expect(response.items.first.product.id).to eq(26)
      expect(response.items.first.product.variant_id).to eq(3)
      expect(response.items.first.product.title).to eq('Sweater')
      expect(response.items.first.product.price).to eq(25.0)
      expect(response.items.first.product.currency).to eq('EUR')
      expect(response.items.first.quantity).to eq(2)
      expect(response.items.first.amount).to eq(50.0)
      expect(response.items.first.currency).to eq('EUR')

      expect(response.items.last.product).to be_a(Kentaa::Api::Resources::Product)
      expect(response.items.last.product.id).to eq(25)
      expect(response.items.last.product.variant_id).to eq(2)
      expect(response.items.last.product.title).to eq('T-shirt')
      expect(response.items.last.product.price).to eq(15.0)
      expect(response.items.last.product.currency).to eq('EUR')
      expect(response.items.last.quantity).to eq(1)
      expect(response.items.last.amount).to eq(15.0)
      expect(response.items.last.currency).to eq('EUR')
    end
  end
end
