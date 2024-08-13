# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Kentaa::Api::Resources::Company do
  subject(:response) { described_class.new(config, data: data[:company]) }

  let(:config) { Kentaa::Api::Config.new(api_key: '12345') }
  let(:data) { JSON.parse(File.read('spec/fixtures/responses/company.json'), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq('Company_1')
    end
  end

  describe '#id' do
    it 'returns the resource id' do
      expect(response.id).to eq(1)
    end
  end

  describe '#parent' do
    it 'returns the parent resource' do
      expect(response.parent).to be_a(Kentaa::Api::Resources::Project)
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

  describe '#commerce_number' do
    it 'returns the commerce number' do
      expect(response.commerce_number).to eq('12345678')
    end
  end

  describe '#total_company_members' do
    it 'returns the total number of company members' do
      expect(response.total_company_members).to eq(2)
    end
  end

  describe '#slug' do
    it 'returns the slug' do
      expect(response.slug).to eq('asperiores-beatae-voluptate-qui')
    end
  end

  describe '#members' do
    it 'returns the team members' do
      expect(response.members).not_to be_empty
      expect(response.members.count).to eq(2)
    end
  end

  describe '#name' do
    it 'returns the name' do
      expect(response.name).to eq('Asperiores beatae voluptate qui.')
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq('Vero aspernatur dolores et excepturi.')
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq('Cum odio est. Consequuntur occaecati sapiente molestiae quam recusandae possimus aut. Ratione cum harum beatae ad repellat minus.')
    end
  end

  describe '#target_amount' do
    it 'returns the target amount' do
      expect(response.target_amount).to eq(2000)
    end
  end

  describe '#total_amount' do
    it 'returns the total amount' do
      expect(response.total_amount).to eq(225.0)
    end
  end

  describe '#total_donations' do
    it 'returns the total donations' do
      expect(response.total_donations).to eq(4)
    end
  end

  describe '#reserved_spots' do
    it 'returns the number of reserved spots' do
      expect(response.reserved_spots).to eq(10)
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

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq('https://demo1.kentaa.nl/company/asperiores-beatae-voluptate-qui')
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq('https://demo1.kentaa.nl/company/asperiores-beatae-voluptate-qui/donate')
    end
  end

  describe '#member_sign_up_url' do
    it 'returns the sign-up URL' do
      expect(response.member_sign_up_url).to eq('https://demo1.kentaa.nl/participate/companies/c9ddaa602de6b76138c4cc31534c9a14ce5404e2')
    end
  end

  describe '#photos' do
    it 'returns the associated photos' do
      expect(response.photos).not_to be_empty
      expect(response.photos.count).to eq(1)

      photo = response.photos.first
      expect(photo).to be_a(Kentaa::Api::Resources::Photo)
      expect(photo.id).to eq(2)
    end
  end

  describe '#videos' do
    it 'returns the associated videos' do
      expect(response.videos).not_to be_empty
      expect(response.videos.count).to eq(1)

      video = response.videos.first
      expect(video).to be_a(Kentaa::Api::Resources::Video)
      expect(video.id).to eq(2)
    end
  end

  describe '#questions' do
    it 'returns the answered questions' do
      expect(response.questions).not_to be_empty
      expect(response.questions.count).to eq(1)

      question = response.questions.first
      expect(question).to be_a(Kentaa::Api::Resources::Question)
      expect(question.id).to eq(2)
    end
  end

  describe '#external_reference' do
    it 'returns the external reference' do
      expect(response.external_reference).to eq('Customer Campaign 1021AA1-11')
    end
  end

  describe '#company_package' do
    it 'returns the company_package' do
      package = response.company_package
      expect(package).to be_a(Kentaa::Api::Resources::CompanyPackage)
      expect(package.id).to eq(1)
      expect(package.amount).to eq(10)
      expect(package.title).to eq('Package title')
      expect(package.description).to eq('Package description')
      expect(package.reservation_type).to eq('specific')
      expect(package.reservation_limit).to eq(10)
    end
  end

  describe '#contact' do
    it 'returns the associated contact' do
      contact = response.contact
      expect(contact).to be_a(Kentaa::Api::Resources::Contact)
      expect(contact.name).to eq('John Doe')
      expect(contact.first_name).to eq('John')
      expect(contact.last_name).to eq('Doe')
      expect(contact.email).to eq('john.doe@kentaa.nl')
      expect(contact.address).to eq('Jansbuitensingel 29')
      expect(contact.street).to eq('Jansbuitensingel')
      expect(contact.house_number).to eq('29')
      expect(contact.zipcode).to eq('6811AD')
      expect(contact.city).to eq('Arnhem')
      expect(contact.country).to eq('NL')
      expect(contact.phone).to eq('0262616240')
      expect(contact.gender).to eq('male')
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
      expect(consent.url).to eq('https://demo1.kentaa.nl/project/projectinformatie')
      expect(consent.terms_conditions_version).to eq('V1 30-05-2018 11:53')
      expect(consent.privacy_version).to eq('V1 30-05-2018 11:53')
    end
  end

  describe '#billing' do
    it 'returns the associated billing' do
      billing = response.billing
      expect(billing).to be_a(Kentaa::Api::Resources::Billing)
      expect(billing.attn).to eq('Example text')
      expect(billing.street).to eq('Jansbuitensingel')
      expect(billing.house_number).to eq('29')
      expect(billing.house_number_addition).to eq('')
      expect(billing.address).to eq('Jansbuitensingel 29')
      expect(billing.address2).to eq('')
      expect(billing.zipcode).to eq('6811AD')
      expect(billing.city).to eq('Arnhem')
      expect(billing.country).to eq('NL')
    end
  end

  describe '#activity' do
    it 'returns the associated activity' do
      expect(response.activity).to be_a(Kentaa::Api::Resources::Activity)
      expect(response.activity.id).to eq(12)
      expect(response.activity.name).to eq('Activity name')
    end
  end

  describe '#donations' do
    it 'returns the donation resources as a List' do
      expect(response.donations).to be_a(Kentaa::Api::Resources::List)
    end
  end
end
