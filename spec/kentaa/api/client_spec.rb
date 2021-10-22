# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kentaa::Api::Client do
  subject(:client) { Kentaa::Api::Client.new(api_key: "12345") }

  describe 'error handling' do
    it 'handles 400s successfully' do
      data = File.read("spec/fixtures/responses/400.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions?created_after=foobar").to_return(status: 400, body: data)

      expect { client.actions(created_after: "foobar").load }.to raise_error(Kentaa::Api::RequestError, "400: Invalid syntax for parameter created_after (expected ISO 8601 string).")
    end

    it 'handles 401s successfully' do
      data = File.read("spec/fixtures/responses/401.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 401, body: data)

      expect { client.actions.load }.to raise_error(Kentaa::Api::RequestError, "401: Invalid API key provided.")
    end

    it 'handles 404s successfully' do
      data = File.read("spec/fixtures/responses/404.json")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 404, body: data)

      expect { client.actions.load }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
    end

    it 'handles 500s successfully' do
      data = File.read("spec/fixtures/responses/500.html")
      stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 500, body: data)

      expect { client.actions.load }.to raise_error(Kentaa::Api::RequestError, /^500: Unable to parse JSON:/)
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
        expect(actions.first).to be_a(Kentaa::Api::Resources::Action)
      end
    end

    describe '#each' do
      it 'returns a list of actions' do
        data = File.read("spec/fixtures/responses/actions.json")
        stub_request(:get, "https://api.kentaa.nl/v1/actions").to_return(status: 200, body: data)

        actions = client.actions
        expect(actions).to be_a(Kentaa::Api::Resources::List)
        expect(actions.count).to eq(2)
        expect(actions.total_entries).to eq(34)
        expect(actions.first).to be_a(Kentaa::Api::Resources::Action)
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

        expect { client.actions.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
      end
    end

    describe '#create' do
      it 'creates an action' do
        data = File.read("spec/fixtures/responses/action.json")
        stub_request(:post, "https://api.kentaa.nl/v1/actions").to_return(status: 201, body: data)

        action = client.actions.create(title: "Lorem ipsum", description: "Dolorum animi qui nihil iure dolore velit. Rerum eius et quo.", owner_id: 2)
        expect(action).to be_a(Kentaa::Api::Resources::Action)
        expect(action.title).to eq("Lorem ipsum")
        expect(action.owner.id).to eq(2)
      end
    end

    describe '#update' do
      it 'updates an action' do
        data = File.read("spec/fixtures/responses/action.json")
        stub_request(:patch, "https://api.kentaa.nl/v1/actions/1").to_return(status: 200, body: data)

        action = client.actions.update(1, title: "Lorem ipsum")
        expect(action).to be_a(Kentaa::Api::Resources::Action)
        expect(action.title).to eq("Lorem ipsum")
      end
    end
  end

  describe '#donation_forms' do
    describe '#all' do
      it 'returns an enumerator for retrieving all donation forms' do
        data = File.read("spec/fixtures/responses/donation_forms.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donation-forms?page=1").to_return(status: 200, body: data)

        donation_forms = client.donation_forms.all
        expect(donation_forms).to be_a(Enumerator)
        expect(donation_forms.count).to eq(1)
        expect(donation_forms.first).to be_a(Kentaa::Api::Resources::DonationForm)
      end
    end

    describe '#each' do
      it 'returns a list of donation forms' do
        data = File.read("spec/fixtures/responses/donation_forms.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donation-forms").to_return(status: 200, body: data)

        donation_forms = client.donation_forms
        expect(donation_forms).to be_a(Kentaa::Api::Resources::List)
        expect(donation_forms.count).to eq(1)
        expect(donation_forms.total_entries).to eq(5)
        expect(donation_forms.first).to be_a(Kentaa::Api::Resources::DonationForm)
      end
    end

    describe '#get' do
      it 'returns a single donation form' do
        data = File.read("spec/fixtures/responses/donation_form.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donation-forms/1").to_return(status: 200, body: data)

        donation_form = client.donation_forms.get(1)
        expect(donation_form).to be_a(Kentaa::Api::Resources::DonationForm)
        expect(donation_form.title).to eq("Lorem ipsum dolor sit amet")
      end

      it 'returns an error when the donation form was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donation-forms/1").to_return(status: 404, body: data)

        expect { client.donation_forms.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
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

    describe '#each' do
      it 'returns a list of donations' do
        data = File.read("spec/fixtures/responses/donations.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations").to_return(status: 200, body: data)

        donations = client.donations
        expect(donations).to be_a(Kentaa::Api::Resources::List)
        expect(donations.count).to eq(1)
        expect(donations.total_entries).to eq(31)
        expect(donations.first).to be_a(Kentaa::Api::Resources::Donation)
      end
    end

    describe '#get' do
      it 'returns a single donation' do
        data = File.read("spec/fixtures/responses/donation.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations/1").to_return(status: 200, body: data)

        donation = client.donations.get(1)
        expect(donation).to be_a(Kentaa::Api::Resources::Donation)
        expect(donation.first_name).to eq("John")
        expect(donation.last_name).to eq("Doe")
      end

      it 'returns an error when the donation was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/donations/1").to_return(status: 404, body: data)

        expect { client.donations.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
      end
    end
  end

  describe '#manual_donations' do
    describe '#all' do
      it 'returns an enumerator for retrieving all manual donations' do
        data = File.read("spec/fixtures/responses/manual_donations.json")
        stub_request(:get, "https://api.kentaa.nl/v1/manual-donations?page=1").to_return(status: 200, body: data)

        donations = client.manual_donations.all
        expect(donations).to be_a(Enumerator)
        expect(donations.count).to eq(1)
        expect(donations.first).to be_a(Kentaa::Api::Resources::ManualDonation)
      end
    end

    describe '#each' do
      it 'returns a list of manual donations' do
        data = File.read("spec/fixtures/responses/manual_donations.json")
        stub_request(:get, "https://api.kentaa.nl/v1/manual-donations").to_return(status: 200, body: data)

        donations = client.manual_donations
        expect(donations).to be_a(Kentaa::Api::Resources::List)
        expect(donations.count).to eq(1)
        expect(donations.total_entries).to eq(4)
        expect(donations.first).to be_a(Kentaa::Api::Resources::ManualDonation)
      end
    end

    describe '#get' do
      it 'returns a single manual donation' do
        data = File.read("spec/fixtures/responses/manual_donation.json")
        stub_request(:get, "https://api.kentaa.nl/v1/manual-donations/1").to_return(status: 200, body: data)

        donation = client.manual_donations.get(1)
        expect(donation).to be_a(Kentaa::Api::Resources::ManualDonation)
        expect(donation.first_name).to eq("John")
        expect(donation.last_name).to eq("Doe")
      end

      it 'returns an error when the donation was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/manual-donations/1").to_return(status: 404, body: data)

        expect { client.manual_donations.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
      end
    end

    describe '#create' do
      it 'creates a manual donation' do
        data = File.read("spec/fixtures/responses/manual_donation.json")
        stub_request(:post, "https://api.kentaa.nl/v1/manual-donations").to_return(status: 201, body: data)

        donation = client.manual_donations.create(first_name: "John", last_name: "Doe")
        expect(donation).to be_a(Kentaa::Api::Resources::ManualDonation)
        expect(donation.first_name).to eq("John")
        expect(donation.last_name).to eq("Doe")
      end
    end

    describe '#update' do
      it 'updates a manual donation' do
        data = File.read("spec/fixtures/responses/manual_donation.json")
        stub_request(:patch, "https://api.kentaa.nl/v1/manual-donations/1").to_return(status: 200, body: data)

        donation = client.manual_donations.update(1, first_name: "John", last_name: "Doe")
        expect(donation).to be_a(Kentaa::Api::Resources::ManualDonation)
        expect(donation.first_name).to eq("John")
        expect(donation.last_name).to eq("Doe")
      end
    end

    describe '#delete' do
      it 'deletes a manual donation' do
        stub_request(:delete, "https://api.kentaa.nl/v1/manual-donations/1").to_return(status: 204)

        donation = client.manual_donations.delete(1)
        expect(donation).to be nil
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
        expect(newsletter_subscriptions.first).to be_a(Kentaa::Api::Resources::NewsletterSubscription)
      end
    end

    describe '#each' do
      it 'returns a list of newsletter subscriptions' do
        data = File.read("spec/fixtures/responses/newsletter_subscriptions.json")
        stub_request(:get, "https://api.kentaa.nl/v1/newsletter-subscriptions").to_return(status: 200, body: data)

        newsletter_subscriptions = client.newsletter_subscriptions
        expect(newsletter_subscriptions).to be_a(Kentaa::Api::Resources::List)
        expect(newsletter_subscriptions.count).to eq(3)
        expect(newsletter_subscriptions.total_entries).to eq(3)
        expect(newsletter_subscriptions.first).to be_a(Kentaa::Api::Resources::NewsletterSubscription)
      end
    end

    describe '#get' do
      it 'returns a single newsletter subscription' do
        data = File.read("spec/fixtures/responses/newsletter_subscription.json")
        stub_request(:get, "https://api.kentaa.nl/v1/newsletter-subscriptions/1").to_return(status: 200, body: data)

        newsletter_subscription = client.newsletter_subscriptions.get(1)
        expect(newsletter_subscription).to be_a(Kentaa::Api::Resources::NewsletterSubscription)
        expect(newsletter_subscription.email).to eq("john.doe@kentaa.nl")
      end

      it 'returns an error when the newsletter subscription was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/newsletter-subscriptions/1").to_return(status: 404, body: data)

        expect { client.newsletter_subscriptions.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
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
        expect(projects.first).to be_a(Kentaa::Api::Resources::Project)
      end
    end

    describe '#each' do
      it 'returns a list of projects' do
        data = File.read("spec/fixtures/responses/projects.json")
        stub_request(:get, "https://api.kentaa.nl/v1/projects").to_return(status: 200, body: data)

        projects = client.projects
        expect(projects).to be_a(Kentaa::Api::Resources::List)
        expect(projects.count).to eq(2)
        expect(projects.total_entries).to eq(10)
        expect(projects.first).to be_a(Kentaa::Api::Resources::Project)
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

        expect { client.projects.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
      end
    end
  end

  describe '#recurring_donors' do
    describe '#all' do
      it 'returns an enumerator for retrieving all recurring donors' do
        data = File.read("spec/fixtures/responses/recurring_donors.json")
        stub_request(:get, "https://api.kentaa.nl/v1/recurring-donors?page=1").to_return(status: 200, body: data)

        recurring_donors = client.recurring_donors.all
        expect(recurring_donors).to be_a(Enumerator)
        expect(recurring_donors.count).to eq(1)
        expect(recurring_donors.first).to be_a(Kentaa::Api::Resources::RecurringDonor)
      end
    end

    describe '#each' do
      it 'returns a list of recurring donors' do
        data = File.read("spec/fixtures/responses/recurring_donors.json")
        stub_request(:get, "https://api.kentaa.nl/v1/recurring-donors").to_return(status: 200, body: data)

        recurring_donors = client.recurring_donors
        expect(recurring_donors).to be_a(Kentaa::Api::Resources::List)
        expect(recurring_donors.count).to eq(1)
        expect(recurring_donors.total_entries).to eq(1)
        expect(recurring_donors.first).to be_a(Kentaa::Api::Resources::RecurringDonor)
      end
    end

    describe '#get' do
      it 'returns a single recurring donor' do
        data = File.read("spec/fixtures/responses/recurring_donor.json")
        stub_request(:get, "https://api.kentaa.nl/v1/recurring-donors/1").to_return(status: 200, body: data)

        recurring_donor = client.recurring_donors.get(1)
        expect(recurring_donor).to be_a(Kentaa::Api::Resources::RecurringDonor)
        expect(recurring_donor.name).to eq("John Doe")
      end

      it 'returns an error when the recurring donor was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/recurring-donors/1").to_return(status: 404, body: data)

        expect { client.recurring_donors.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
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
        expect(segments.first).to be_a(Kentaa::Api::Resources::Segment)
      end
    end

    describe '#each' do
      it 'returns a list of segments' do
        data = File.read("spec/fixtures/responses/segments.json")
        stub_request(:get, "https://api.kentaa.nl/v1/segments").to_return(status: 200, body: data)

        segments = client.segments
        expect(segments).to be_a(Kentaa::Api::Resources::List)
        expect(segments.count).to eq(1)
        expect(segments.total_entries).to eq(3)
        expect(segments.first).to be_a(Kentaa::Api::Resources::Segment)
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

        expect { client.segments.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
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
        expect(site.title).to eq("Aut est maxime nostrum.")
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
        expect(teams.first).to be_a(Kentaa::Api::Resources::Team)
      end
    end

    describe '#each' do
      it 'returns a list of teams' do
        data = File.read("spec/fixtures/responses/teams.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams").to_return(status: 200, body: data)

        teams = client.teams
        expect(teams).to be_a(Kentaa::Api::Resources::List)
        expect(teams.count).to eq(1)
        expect(teams.total_entries).to eq(8)
        expect(teams.first).to be_a(Kentaa::Api::Resources::Team)
      end
    end

    describe '#get' do
      it 'returns a single team' do
        data = File.read("spec/fixtures/responses/team.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams/1").to_return(status: 200, body: data)

        team = client.teams.get(1)
        expect(team).to be_a(Kentaa::Api::Resources::Team)
        expect(team.name).to eq("Asperiores beatae voluptate qui.")
      end

      it 'returns an error when the team was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/teams/1").to_return(status: 404, body: data)

        expect { client.teams.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
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
        expect(users.first).to be_a(Kentaa::Api::Resources::User)
      end
    end

    describe '#each' do
      it 'returns a list of users' do
        data = File.read("spec/fixtures/responses/users.json")
        stub_request(:get, "https://api.kentaa.nl/v1/users").to_return(status: 200, body: data)

        users = client.users
        expect(users).to be_a(Kentaa::Api::Resources::List)
        expect(users.count).to eq(1)
        expect(users.total_entries).to eq(31)
        expect(users.first).to be_a(Kentaa::Api::Resources::User)
      end
    end

    describe '#get' do
      it 'returns a single user' do
        data = File.read("spec/fixtures/responses/user.json")
        stub_request(:get, "https://api.kentaa.nl/v1/users/1").to_return(status: 200, body: data)

        user = client.users.get(1)
        expect(user).to be_a(Kentaa::Api::Resources::User)
        expect(user.name).to eq("John Doe")
      end

      it 'returns an error when the team was not found' do
        data = File.read("spec/fixtures/responses/404.json")
        stub_request(:get, "https://api.kentaa.nl/v1/users/1").to_return(status: 404, body: data)

        expect { client.users.get(1) }.to raise_error(Kentaa::Api::RequestError, "404: Requested resource was not found.")
      end
    end

    describe '#create' do
      it 'creates an user' do
        data = File.read("spec/fixtures/responses/user.json")
        stub_request(:post, "https://api.kentaa.nl/v1/users").to_return(status: 201, body: data)

        user = client.users.create(first_name: "John", last_name: "Doe")
        expect(user).to be_a(Kentaa::Api::Resources::User)
        expect(user.first_name).to eq("John")
        expect(user.last_name).to eq("Doe")
      end
    end

    describe '#update' do
      it 'updates an user' do
        data = File.read("spec/fixtures/responses/user.json")
        stub_request(:patch, "https://api.kentaa.nl/v1/users/1").to_return(status: 200, body: data)

        user = client.users.update(1, first_name: "John")
        expect(user).to be_a(Kentaa::Api::Resources::User)
        expect(user.first_name).to eq("John")
        expect(user.last_name).to eq("Doe")
      end
    end

    describe '#auth' do
      it 'authenticates an user succesfully' do
        data = File.read("spec/fixtures/responses/user.json")
        stub_request(:post, "https://api.kentaa.nl/v1/users/auth").to_return(status: 200, body: data)

        user = client.users.auth(email: "john.doe@kentaa.nl", password: "secret")
        expect(user).to be_a(Kentaa::Api::Resources::User)
        expect(user.first_name).to eq("John")
        expect(user.last_name).to eq("Doe")
      end

      it 'returns an error when the authentication was unsuccessful' do
        data = File.read("spec/fixtures/responses/403.json")
        stub_request(:post, "https://api.kentaa.nl/v1/users/auth").to_return(status: 403, body: data)

        expect { client.users.auth(email: "john.doe@kentaa.nl", password: "invalid") }.to raise_error(Kentaa::Api::RequestError, "403: Invalid email or password.")
      end
    end
  end
end
