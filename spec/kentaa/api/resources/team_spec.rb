# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Resources::Team do
  subject(:response) { Kentaa::Api::Resources::Team.new(config, data: data[:team]) }

  let(:config) { Kentaa::Api::Config.new(api_key: "12345") }
  let(:data) { JSON.parse(File.read("spec/fixtures/responses/team.json"), symbolize_names: true) }

  describe '#object_key' do
    it 'returns the object key' do
      expect(response.object_key).to eq("Team_1")
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

  describe '#slug' do
    it 'returns the slug' do
      expect(response.slug).to eq("asperiores-beatae-voluptate-qui")
    end
  end

  describe '#owner' do
    it 'returns the team owner' do
      expect(response.owner).to be_a(Kentaa::Api::Resources::User)
      expect(response.owner.first_name).to eq("John")
      expect(response.owner.last_name).to eq("Doe")
      expect(response.owner.email).to eq("john.doe@kentaa.nl")
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
      expect(response.name).to eq("Asperiores beatae voluptate qui.")
    end
  end

  describe '#title' do
    it 'returns the title' do
      expect(response.title).to eq("Vero aspernatur dolores et excepturi.")
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(response.description).to eq("Cum odio est. Consequuntur occaecati sapiente molestiae quam recusandae possimus aut. Ratione cum harum beatae ad repellat minus.")
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

  describe '#visible?' do
    it 'returns true when visible' do
      expect(response.visible?).to be true
    end
  end

  describe '#end_date' do
    it 'returns the end date' do
      expect(response.end_date).to be nil
    end
  end

  describe '#url' do
    it 'returns the page URL' do
      expect(response.url).to eq("https://demo1.kentaa.nl/team/asperiores-beatae-voluptate-qui")
    end
  end

  describe '#donate_url' do
    it 'returns the donate URL' do
      expect(response.donate_url).to eq("https://demo1.kentaa.nl/team/asperiores-beatae-voluptate-qui/doneren")
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

  describe '#external_reference' do
    it 'returns the external reference' do
      expect(response.external_reference).to be nil
    end
  end
end
