# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Performance do
  subject(:response) { Kentaa::Api::Resources::Performance.new(config, data: data[:performance]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/performance.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('ActionPerformance_1')
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#action' do
    it 'returns the action resource' do
      expect(response.action).to be_a(Kentaa::Api::Resources::Action)
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

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq('First tour')
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq('The first tour on my new bike.')
    end
  end

  describe '#performance_type' do
    it 'returns the performance_type' do
      expect(response.performance_type).to eq('biking')
    end
  end

  describe '#performance_at' do
    it 'returns the performance_at timestamp' do
      expect(response.performance_at).to be_a(Time)
    end
  end

  describe '#distance' do
    it 'returns the distance' do
      expect(response.distance).to eq(65.25)
    end
  end

  describe '#unit' do
    it 'returns the unit' do
      expect(response.unit).to eq('km')
    end
  end

  describe '#photos' do
    describe '#all' do
      it 'returns an enumerator for retrieving all performance photos' do
        data = File.read('spec/fixtures/responses/performance_photos.json')
        stub_request(:get, 'https://api.kentaa.nl/v1/actions/1/performances/1/photos?page=1').to_return(status: 200, body: data)

        photos = response.photos.all
        expect(photos).to be_a(Enumerator)
        expect(photos.count).to eq(2)
        expect(photos.first).to be_a(Kentaa::Api::Resources::PerformancePhoto)
      end
    end

    describe '#each' do
      it 'returns a list of performance photos' do
        data = File.read('spec/fixtures/responses/performance_photos.json')
        stub_request(:get, 'https://api.kentaa.nl/v1/actions/1/performances/1/photos').to_return(status: 200, body: data)

        photos = response.photos
        expect(photos).to be_a(Kentaa::Api::Resources::List)
        expect(photos.count).to eq(2)
        expect(photos.total_entries).to eq(2)
        expect(photos.first).to be_a(Kentaa::Api::Resources::PerformancePhoto)
      end
    end

    describe '#get' do
      it 'returns a single performance photo' do
        data = File.read('spec/fixtures/responses/performance_photo.json')
        stub_request(:get, 'https://api.kentaa.nl/v1/actions/1/performances/1/photos/1').to_return(status: 200, body: data)

        photo = response.photos.get(1)
        expect(photo).to be_a(Kentaa::Api::Resources::PerformancePhoto)
        expect(photo.image_url).to eq('https://d2a3ux41sjxpco.cloudfront.net/action_performance_photos/file/1/normal_8ce42aeb3bbb1b4964e621b42691f13d4dfa3f21.jpg')
      end

      it 'returns an error when the performance photo was not found' do
        data = File.read('spec/fixtures/responses/404.json')
        stub_request(:get, 'https://api.kentaa.nl/v1/actions/1/performances/1/photos/1').to_return(status: 404, body: data)

        expect { response.photos.get(1) }.to raise_error(Kentaa::Api::RequestError, '404: Requested resource was not found.')
      end
    end

    describe '#create' do
      it 'creates a performance photo' do
        data = File.read('spec/fixtures/responses/performance_photo.json')
        stub_request(:post, 'https://api.kentaa.nl/v1/actions/1/performances/1/photos').to_return(status: 201, body: data)

        photo = response.photos.create(io: File.open('spec/fixtures/test.jpg'), content_type: 'image/jpeg')
        expect(photo).to be_a(Kentaa::Api::Resources::PerformancePhoto)
      end
    end
  end
end
