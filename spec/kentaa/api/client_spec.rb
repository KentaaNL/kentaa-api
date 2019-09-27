# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Client do
  subject(:client) { Kentaa::Api::Client.new(config) }

  let(:config) { Kentaa::Api::Config.new("12345") }

  describe 'error handling' do
    it 'handles 400s successfully' do
      data = File.read("spec/fixtures/responses/400.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions?created_after=foobar").to_return(status: 400, body: data)

      expect { client.actions.list(created_after: "foobar") }.to raise_error(Kentaa::Api::RequestError, "Invalid syntax for parameter created_after (expected ISO 8601 string).")
    end

    it 'handles 401s successfully' do
      data = File.read("spec/fixtures/responses/401.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 401, body: data)

      expect { client.actions.list }.to raise_error(Kentaa::Api::RequestError, "Invalid API key provided.")
    end

    it 'handles 404s successfully' do
      data = File.read("spec/fixtures/responses/404.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 404, body: data)

      expect { client.actions.list }.to raise_error(Kentaa::Api::RequestError, "Requested resource was not found.")
    end

    it 'handles 500s successfully' do
      data = File.read("spec/fixtures/responses/500.html")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 500, body: data)

      expect { client.actions.list }.to raise_error(Kentaa::Api::RequestError, /^Unable to parse JSON:/)
    end
  end

  describe '#actions' do
    describe '#all' do
      it 'returns an enumerator for retrieving all actions' do
        data = File.read("spec/fixtures/responses/actions.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/empty.json")
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
        expect(actions).to be_a(Kentaa::Api::Resources::Actions)
        expect(actions.count).to eq(2)
        expect(actions.total_entries).to eq(34)
      end
    end

    describe '#get' do
      it 'returns a single action' do
        data = File.read("spec/fixtures/responses/action.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions/1").to_return(status: 200, body: data)

        action = client.actions.get(1)
        expect(action).to be_a(Kentaa::Api::Resources::Action)
        expect(action.title).to eq("Lorem ipsum")
      end

      it 'returns an error when the action was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions/1").to_return(status: 404, body: data)

        expect { client.actions.get(1) }.to raise_error(Kentaa::Api::RequestError, "Requested resource was not found.")
      end
    end
  end

  describe '#donations' do
    describe '#all' do
      it 'returns an enumerator for retrieving all donations' do
        data = File.read("spec/fixtures/responses/donations.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/empty.json")
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
        expect(donations).to be_a(Kentaa::Api::Resources::Donations)
        expect(donations.count).to eq(1)
        expect(donations.total_entries).to eq(31)
      end
    end

    describe '#get' do
      it 'returns a single donation' do
        data = File.read("spec/fixtures/responses/donation.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations/1").to_return(status: 200, body: data)

        donation = client.donations.get(1)
        expect(donation).to be_a(Kentaa::Api::Resources::Donation)
        expect(donation.amount).not_to be nil
      end

      it 'returns an error when the donation was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations/1").to_return(status: 404, body: data)

        expect { client.donations.get(1) }.to raise_error(Kentaa::Api::RequestError, "Requested resource was not found.")
      end
    end
  end

  describe '#newsletter_subscriptions' do
    describe '#all' do
      it 'returns an enumerator for retrieving all newsletter subscriptions' do
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
        expect(newsletter_subscriptions).to be_a(Kentaa::Api::Resources::NewsletterSubscriptions)
        expect(newsletter_subscriptions.count).to eq(3)
        expect(newsletter_subscriptions.total_entries).to eq(3)
      end
    end

    describe '#get' do
      it 'returns a single newsletter subscription' do
        data = File.read("spec/fixtures/responses/newsletter_subscription.json")
        stub_request(:get, "https://api.kentaa.nl/v1/newsletter-subscriptions/1").to_return(status: 200, body: data)

        newsletter_subscription = client.newsletter_subscriptions.get(1)
        expect(newsletter_subscription).to be_a(Kentaa::Api::Resources::NewsletterSubscription)
        expect(newsletter_subscription.email).not_to be nil
      end

      it 'returns an error when the newsletter subscription was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/newsletter-subscriptions/1").to_return(status: 404, body: data)

        expect { client.newsletter_subscriptions.get(1) }.to raise_error(Kentaa::Api::RequestError, "Requested resource was not found.")
      end
    end
  end

  describe '#projects' do
    describe '#all' do
      it 'returns an enumerator for retrieving all projects' do
        data = File.read("spec/fixtures/responses/projects.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/empty.json")
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
        expect(projects).to be_a(Kentaa::Api::Resources::Projects)
        expect(projects.count).to eq(2)
        expect(projects.total_entries).to eq(6)
      end
    end

    describe '#get' do
      it 'returns a single project' do
        data = File.read("spec/fixtures/responses/project.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects/1").to_return(status: 200, body: data)

        project = client.projects.get(1)
        expect(project).to be_a(Kentaa::Api::Resources::Project)
        expect(project.title).to eq("Dignissimos provident rerum enim alias magni asperna...")
      end

      it 'returns an error when the project was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects/1").to_return(status: 404, body: data)

        expect { client.projects.get(1) }.to raise_error(Kentaa::Api::RequestError, "Requested resource was not found.")
      end
    end
  end

  describe '#segments' do
    describe '#all' do
      it 'returns an enumerator for retrieving all segments' do
        data = File.read("spec/fixtures/responses/segments.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/empty.json")
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
        expect(segments).to be_a(Kentaa::Api::Resources::Segments)
        expect(segments.count).to eq(1)
        expect(segments.total_entries).to eq(3)
      end
    end

    describe '#get' do
      it 'returns a single segment' do
        data = File.read("spec/fixtures/responses/segment.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments/1").to_return(status: 200, body: data)

        segment = client.segments.get(1)
        expect(segment).to be_a(Kentaa::Api::Resources::Segment)
        expect(segment.title).not_to be nil
      end

      it 'returns an error when the segment was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments/1").to_return(status: 404, body: data)

        expect { client.segments.get(1) }.to raise_error(Kentaa::Api::RequestError, "Requested resource was not found.")
      end
    end
  end

  describe '#sites' do
    describe '#current' do
      it 'returns the current site' do
        data = File.read("spec/fixtures/responses/site.json")
        stub_request(:get, "https://api.kentaa.nl/v1/sites/current").to_return(status: 200, body: data)

        site = client.sites.current
        expect(site).to be_a(Kentaa::Api::Resources::Site)
        expect(site.title).not_to be nil
      end
    end
  end

  describe '#teams' do
    describe '#all' do
      it 'returns an enumerator for retrieving all teams' do
        data = File.read("spec/fixtures/responses/teams.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/empty.json")
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
        expect(teams).to be_a(Kentaa::Api::Resources::Teams)
        expect(teams.count).to eq(1)
        expect(teams.total_entries).to eq(8)
      end
    end

    describe '#get' do
      it 'returns a single team' do
        data = File.read("spec/fixtures/responses/team.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams/1").to_return(status: 200, body: data)

        team = client.teams.get(1)
        expect(team).to be_a(Kentaa::Api::Resources::Team)
        expect(team.name).not_to be nil
      end

      it 'returns an error when the team was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams/1").to_return(status: 404, body: data)

        expect { client.teams.get(1) }.to raise_error(Kentaa::Api::RequestError, "Requested resource was not found.")
      end
    end
  end

  describe '#users' do
    describe '#all' do
      it 'returns an enumerator for retrieving all users' do
        data = File.read("spec/fixtures/responses/users.json")
        stub_request(:get, "https://api.kentaa.nl/v1/users?page=1").to_return(status: 200, body: data)
        data = File.read("spec/fixtures/responses/empty.json")
        stub_request(:get, "https://api.kentaa.nl/v1/users?page=2").to_return(status: 200, body: data)

        users = client.users.all
        expect(users).to be_a(Enumerator)
        expect(users.count).to eq(1)
      end
    end

    describe '#list' do
      it 'returns a list of users' do
        data = File.read("spec/fixtures/responses/users.json")
        stub_request(:get, "https://api.kentaa.nl/v1/users").to_return(status: 200, body: data)

        users = client.users.list
        expect(users).to be_a(Kentaa::Api::Resources::Users)
        expect(users.count).to eq(1)
        expect(users.total_entries).to eq(31)
      end
    end

    describe '#get' do
      it 'returns a single user' do
        data = File.read("spec/fixtures/responses/user.json")
        stub_request(:get, "https://api.kentaa.nl/v1/users/1").to_return(status: 200, body: data)

        user = client.users.get(1)
        expect(user).to be_a(Kentaa::Api::Resources::User)
        expect(user.name).not_to be nil
      end

      it 'returns an error when the team was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/users/1").to_return(status: 404, body: data)

        expect { client.users.get(1) }.to raise_error(Kentaa::Api::RequestError, "Requested resource was not found.")
      end
    end
  end
end
