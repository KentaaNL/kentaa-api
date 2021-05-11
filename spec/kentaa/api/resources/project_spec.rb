# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::Project do
  subject(:response) { Kentaa::Api::Resources::Project.new(config, data: data[:project]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/project.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("Project_1")
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#parent' do
    it 'returns the parent resource' do
      expect(response.parent).to be_a(Kentaa::Api::Resources::Segment)
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
      expect(response.slug).to eq("dignissimos-provident")
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq("Dignissimos provident rerum enim alias magni asperna...")
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq("Fugiat et nulla mollitia. Ut omnis adipisci et. Consequatur voluptatibus est dicta rem.")
    end
  end

  describe '#target_amount' do
    it 'returns the target amount' do
      expect(response.target_amount).to eq(250_000)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(1250.0)
    end
  end

  describe '#total_donations' do
    it 'returns the total donations' do
      expect(response.total_donations).to eq(18)
    end
  end

  describe '#visible?' do
    it 'returns true when visible' do
      expect(response.visible?).to be true
    end
  end

  describe '#end_date' do
    it 'returns the end date' do
      expect(response.end_date).to be_a(Time)
    end
  end

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq("https://demo1.kentaa.nl/project/dignissimos-provident-rerum-enim-alias-magni-asperna")
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq("https://demo1.kentaa.nl/project/dignissimos-provident-rerum-enim-alias-magni-asperna/doneren")
    end
  end

  describe '#photos' do
    it 'returns the associated photos' do
      expect(response.photos).to be_empty
    end
  end

  describe '#videos' do
    it 'returns the associated videos' do
      expect(response.videos).to be_empty
    end
  end

  describe '#questions' do
    it 'returns the answered questions' do
      expect(response.questions).to be_empty
    end
  end

  describe '#consent' do
    it 'returns the associated consent' do
      expect(response.consent).to be nil
    end
  end

  describe '#contact' do
    it 'returns the associated contact' do
      expect(response.contact).to be_a(Kentaa::Api::Resources::Contact)
      expect(response.contact.name).to eq("John Doe")
      expect(response.contact.first_name).to eq("John")
      expect(response.contact.last_name).to eq("Doe")
      expect(response.contact.email).to eq("john.doe@kentaa.nl")
      expect(response.contact.address).to eq("Jansbuitensingel 29")
      expect(response.contact.street).to eq("Jansbuitensingel")
      expect(response.contact.house_number).to eq("29")
      expect(response.contact.zipcode).to eq("6811AD")
      expect(response.contact.city).to eq("Arnhem")
      expect(response.contact.country).to eq("NL")
      expect(response.contact.phone).to eq("0262616240")
      expect(response.contact.gender).to eq("male")
    end
  end

  describe '#external_reference' do
    it 'returns the external reference' do
      expect(response.external_reference).to be nil
    end
  end

  describe '#donations' do
    it 'returns the donations resource' do
      expect(response.donations).to be_a(Kentaa::Api::Resources::Donations)
    end
  end

  describe '#manual_donations' do
    it 'returns the manual donations resource' do
      expect(response.manual_donations).to be_a(Kentaa::Api::Resources::ManualDonations)
    end
  end

  describe '#newsletter_subscriptions' do
    it 'returns the newsletter subscriptions resource' do
      expect(response.newsletter_subscriptions).to be_a(Kentaa::Api::Resources::NewsletterSubscriptions)
    end
  end
end
