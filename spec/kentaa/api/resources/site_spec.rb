# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Site do
  subject(:response) { described_class.new(config, data: data[:site]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/site.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('Site_6')
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(6)
    end
  end

  describe '#public_id' do
    it 'returns the public id' do
      expect(response.public_id).to eq('hVVHrbfTAfYz')
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

  describe '#host' do
    it 'returns the host name' do
      expect(response.host).to eq('demo1.kentaa.nl')
    end
  end

  describe '#name' do
    it 'returns the site name' do
      expect(response.name).to eq('Demo')
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq('Aut est maxime nostrum.')
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq('Maiores ut velit fugiat eos. Quae est nostrum rerum aut et nihil. Sequi eveniet occaecati et est corporis et enim.')
    end
  end

  describe '#target_amount' do
    it 'returns the target amount' do
      expect(response.target_amount).to eq(5000)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(0.0)
    end
  end

  describe '#total_donations' do
    it 'returns the total donations' do
      expect(response.total_donations).to eq(0)
    end
  end

  describe '#default_currency' do
    it 'returns the default currency' do
      expect(response.default_currency).to eq('EUR')
    end
  end

  describe '#end_date' do
    it 'returns the end date' do
      expect(response.end_date).to be_nil
    end
  end

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq('https://demo1.kentaa.nl/')
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq('https://demo1.kentaa.nl/donate')
    end
  end

  describe '#video_url' do
    it 'returns the video URL' do
      expect(response.video_url).to eq('https://www.youtube.com/watch?v=VLv1jKC39jGQk')
    end
  end

  describe '#owner_name' do
    it 'returns the owner name' do
      expect(response.owner_name).to eq('John doe')
    end
  end

  describe '#owner_email' do
    it 'returns the owner email' do
      expect(response.owner_email).to eq('johndoe@example.com')
    end
  end

  describe '#banners' do
    it 'returns the associated banners' do
      expect(response.banners).not_to be_empty
      expect(response.banners.count).to eq(1)
      expect(response.banners.first).to be_a(Kentaa::Api::Resources::Banner)
    end
  end

  describe '#logos' do
    it 'returns the associated logos' do
      expect(response.logos).not_to be_empty
      expect(response.logos.count).to eq(2)
      expect(response.logos.first).to be_a(Kentaa::Api::Resources::Logo)
    end
  end

  describe '#external_reference' do
    it 'returns the external reference' do
      expect(response.external_reference).to eq('Customer Campaign 1021AA1-11')
    end
  end

  describe '#background_image_url' do
    it 'returns the background image URL' do
      expect(response.background_image_url).to eq('https://cdn.kentaa.nl/background_images/site_theme/background_image/2238/c84048633c78cd54cf3000a244738d8005d265c1.jpg')
    end
  end

  describe '#sign_up_flow_background_image_url' do
    it 'returns the background image URL' do
      expect(response.sign_up_flow_background_image_url).to eq('https://cdn.kentaa.nl/background_images/site_setting/sign_up_flow_background_image/3804/0afc0d7f0932b5f8f4ed49b06e768a6eb36e31b3.jpg')
    end
  end

  describe '#theme' do
    it 'returns the theme settings' do
      expect(response.theme).to be_a(Kentaa::Api::Resources::Theme)
      expect(response.theme.primary_color).to eq('#6b0a0a')
      expect(response.theme.contrast_color).to eq('#400b0b')
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

  describe '#newsletter_subscriptions' do
    it 'returns the newsletter subscription resources as a List' do
      expect(response.newsletter_subscriptions).to be_a(Kentaa::Api::Resources::List)
    end
  end

  describe '#activities' do
    it 'returns the activity resources as a List' do
      expect(response.activities).to be_a(Kentaa::Api::Resources::List)
    end
  end

  describe '#orders' do
    it 'returns the order resources as a List' do
      expect(response.orders).to be_a(Kentaa::Api::Resources::List)
    end
  end
end
