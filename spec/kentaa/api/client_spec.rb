# frozen_string_literal: true

require "spec_helper"

describe Kentaa::Api::Client do
  subject(:client) { Kentaa::Api::Client.new("12345") }

  describe 'error handling' do
    it 'handles 400s successfully' do
      data = File.read("spec/fixtures/responses/400.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions?created_after=foobar").to_return(status: 400, body: data)

      actions = client.actions.list(created_after: "foobar")
      expect(actions.error?).to be true
      expect(actions.message).to eq("Invalid syntax for parameter created_after (expected ISO 8601 string).")
    end

    it 'handles 401s successfully' do
      data = File.read("spec/fixtures/responses/401.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 401, body: data)

      actions = client.actions.list
      expect(actions.error?).to be true
      expect(actions.message).to eq("Invalid API key provided.")
    end

    it 'handles 404s successfully' do
      data = File.read("spec/fixtures/responses/404.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 404, body: data)

      actions = client.actions.list
      expect(actions.error?).to be true
      expect(actions.message).to eq("Requested resource was not found.")
    end

    it 'handles 500s successfully' do
      data = File.read("spec/fixtures/responses/500.html")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 500, body: data)

      actions = client.actions.list
      expect(actions.error?).to be true
      expect(actions.message).to include("Unable to parse JSON:")
    end
  end

  describe '#actions' do
    describe '#all' do
      it 'returns a enumerator for retrieving all actions' do
        data = File.read("spec/fixtures/responses/actions.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions?page=2").to_return(status: 200, body: data)

        actions = client.actions.all
        expect(actions).to be_a(Enumerator)
        expect(actions.count).to eq(2)
      end
    end

    describe '#list' do
      it 'returns a list of actions' do
        data = File.read("spec/fixtures/responses/actions.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 200, body: data)

        actions = client.actions.list
        expect(actions).to be_a(Kentaa::Api::Responses::Actions)
        expect(actions.error?).to be false
        expect(actions.count).to eq(2)
      end
    end

    describe '#get' do
      it 'returns a single action' do
        data = File.read("spec/fixtures/responses/action.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions/1").to_return(status: 200, body: data)

        action = client.actions.get(1)
        expect(action).to be_a(Kentaa::Api::Responses::Action)
        expect(action.error?).to be false
      end

      it 'returns an error when the action was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions/1").to_return(status: 404, body: data)

        action = client.actions.get(1)
        expect(action).to be_a(Kentaa::Api::Responses::Action)
        expect(action.error?).to be true
      end
    end
  end

  describe '#donations' do
    describe '#all' do
      it 'returns a enumerator for retrieving all donations' do
        data = File.read("spec/fixtures/responses/donations.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations?page=2").to_return(status: 200, body: data)

        donations = client.donations.all
        expect(donations).to be_a(Enumerator)
        expect(donations.count).to eq(1)
      end
    end

    describe '#list' do
      it 'returns a list of donations' do
        data = File.read("spec/fixtures/responses/donations.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations").to_return(status: 200, body: data)

        donations = client.donations.list
        expect(donations).to be_a(Kentaa::Api::Responses::Donations)
        expect(donations.error?).to be false
        expect(donations.count).to eq(1)
      end
    end

    describe '#get' do
      it 'returns a single donation' do
        data = File.read("spec/fixtures/responses/donation.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations/1").to_return(status: 200, body: data)

        donation = client.donations.get(1)
        expect(donation).to be_a(Kentaa::Api::Responses::Donation)
        expect(donation.error?).to be false
        expect(donation.amount).to be
      end

      it 'returns an error when the donation was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations/1").to_return(status: 404, body: data)

        donation = client.donations.get(1)
        expect(donation).to be_a(Kentaa::Api::Responses::Donation)
        expect(donation.error?).to be true
      end
    end
  end

  describe '#newsletter_subscriptions' do
    describe '#all' do
      it 'returns a enumerator for retrieving all newsletter subscriptions' do
        data = File.read("spec/fixtures/responses/newsletter_subscriptions.json")
        stub_request(:get, "https://api.kentaa.nl/v1/newsletter-subscriptions?page=1").to_return(status: 200, body: data)

        newsletter_subscriptions = client.newsletter_subscriptions.all
        expect(newsletter_subscriptions).to be_a(Enumerator)
        expect(newsletter_subscriptions.count).to eq(3)
      end
    end

    describe '#list' do
      it 'returns a list of newsletter subscriptions' do
        data = File.read("spec/fixtures/responses/newsletter_subscriptions.json")
        stub_request(:get, "https://api.kentaa.nl/v1/newsletter-subscriptions").to_return(status: 200, body: data)

        newsletter_subscriptions = client.newsletter_subscriptions.list
        expect(newsletter_subscriptions).to be_a(Kentaa::Api::Responses::NewsletterSubscriptions)
        expect(newsletter_subscriptions.error?).to be false
        expect(newsletter_subscriptions.count).to eq(3)
      end
    end
  end

  describe '#projects' do
    describe '#all' do
      it 'returns a enumerator for retrieving all projects' do
        data = File.read("spec/fixtures/responses/projects.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects?page=2").to_return(status: 200, body: data)

        projects = client.projects.all
        expect(projects).to be_a(Enumerator)
        expect(projects.count).to eq(2)
      end
    end

    describe '#list' do
      it 'returns a list of projects' do
        data = File.read("spec/fixtures/responses/projects.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects").to_return(status: 200, body: data)

        projects = client.projects.list
        expect(projects).to be_a(Kentaa::Api::Responses::Projects)
        expect(projects.error?).to be false
        expect(projects.count).to eq(2)
      end
    end

    describe '#get' do
      it 'returns a single project' do
        data = File.read("spec/fixtures/responses/project.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects/1").to_return(status: 200, body: data)

        project = client.projects.get(1)
        expect(project).to be_a(Kentaa::Api::Responses::Project)
        expect(project.error?).to be false
        expect(project.title).to be
      end

      it 'returns an error when the project was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects/1").to_return(status: 404, body: data)

        project = client.projects.get(1)
        expect(project).to be_a(Kentaa::Api::Responses::Project)
        expect(project.error?).to be true
      end
    end
  end

  describe '#segments' do
    describe '#all' do
      it 'returns a enumerator for retrieving all segments' do
        data = File.read("spec/fixtures/responses/segments.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments?page=2").to_return(status: 200, body: data)

        segments = client.segments.all
        expect(segments).to be_a(Enumerator)
        expect(segments.count).to eq(1)
      end
    end

    describe '#list' do
      it 'returns a list of segments' do
        data = File.read("spec/fixtures/responses/segments.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments").to_return(status: 200, body: data)

        segments = client.segments.list
        expect(segments).to be_a(Kentaa::Api::Responses::Segments)
        expect(segments.error?).to be false
        expect(segments.count).to eq(1)
      end
    end

    describe '#get' do
      it 'returns a single segment' do
        data = File.read("spec/fixtures/responses/segment.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments/1").to_return(status: 200, body: data)

        segment = client.segments.get(1)
        expect(segment).to be_a(Kentaa::Api::Responses::Segment)
        expect(segment.error?).to be false
        expect(segment.title).to be
      end

      it 'returns an error when the segment was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments/1").to_return(status: 404, body: data)

        segment = client.segments.get(1)
        expect(segment).to be_a(Kentaa::Api::Responses::Segment)
        expect(segment.error?).to be true
      end
    end
  end

  describe '#sites' do
    describe '#current' do
      it 'returns the current site' do
        data = File.read("spec/fixtures/responses/site.json")
        stub_request(:get, "https://api.kentaa.nl/v1/sites/current").to_return(status: 200, body: data)

        site = client.sites.current
        expect(site).to be_a(Kentaa::Api::Responses::Site)
        expect(site.error?).to be false
        expect(site.title).to be
      end
    end
  end

  describe '#teams' do
    describe '#all' do
      it 'returns a enumerator for retrieving all teams' do
        data = File.read("spec/fixtures/responses/teams.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams?page=2").to_return(status: 200, body: data)

        teams = client.teams.all
        expect(teams).to be_a(Enumerator)
        expect(teams.count).to eq(1)
      end
    end

    describe '#list' do
      it 'returns a list of teams' do
        data = File.read("spec/fixtures/responses/teams.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams").to_return(status: 200, body: data)

        teams = client.teams.list
        expect(teams).to be_a(Kentaa::Api::Responses::Teams)
        expect(teams.error?).to be false
        expect(teams.count).to eq(1)
      end
    end

    describe '#get' do
      it 'returns a single team' do
        data = File.read("spec/fixtures/responses/team.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams/1").to_return(status: 200, body: data)

        team = client.teams.get(1)
        expect(team).to be_a(Kentaa::Api::Responses::Team)
        expect(team.error?).to be false
        expect(team.name).to be
      end

      it 'returns an error when the team was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams/1").to_return(status: 404, body: data)

        team = client.teams.get(1)
        expect(team).to be_a(Kentaa::Api::Responses::Team)
        expect(team.error?).to be true
      end
    end
  end
end
