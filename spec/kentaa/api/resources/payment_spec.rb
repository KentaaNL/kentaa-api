# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Payment do
  subject(:response) { described_class.new(config, data: data[:payment]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/payment.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('Payment_1')
    end
  end

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
      expect(response.site_id).to eq(4)
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

  describe '#currency' do
    it 'returns the payment currency' do
      expect(response.currency).to eq('EUR')
    end
  end

  describe '#amount' do
    it 'returns the payment amount' do
      expect(response.amount).to eq(BigDecimal('90.4'))
    end
  end

  describe '#invoicenumber' do
    it 'returns the invoice number' do
      expect(response.invoicenumber).to eq('T2021.0004.0000001')
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

  describe '#account_iban' do
    it 'returns the consumer IBAN' do
      expect(response.account_iban).to eq('NL44RABO0123456789')
    end
  end

  describe '#account_bic' do
    it 'returns the consumer BIC' do
      expect(response.account_bic).to eq('RABONL2U')
    end
  end

  describe '#account_name' do
    it 'returns the consumer name' do
      expect(response.account_name).to eq('J. de Tester')
    end
  end

  describe '#description' do
    it 'returns the payment description' do
      expect(response.description).to eq('Example payment')
    end
  end

  describe '#donations' do
    it 'returns the associated donations' do
      expect(response.donations).not_to be_empty
      expect(response.donations.count).to eq(1)

      donation = response.donations.first
      expect(donation).to be_a(Kentaa::Api::Resources::Donation)
      expect(donation.first_name).to eq('John')
      expect(donation.last_name).to eq('Doe')
      expect(donation.total_amount).to eq(BigDecimal('25.4'))
    end
  end

  describe '#orders' do
    it 'returns the associated orders' do
      expect(response.orders).not_to be_empty
      expect(response.orders.count).to eq(1)

      order = response.orders.first
      expect(order).to be_a(Kentaa::Api::Resources::Order)
      expect(order.first_name).to eq('John')
      expect(order.last_name).to eq('Doe')
      expect(order.total_amount).to eq(65)
    end
  end
end
