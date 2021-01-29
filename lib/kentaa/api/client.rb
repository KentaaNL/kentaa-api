# frozen_string_literal: true

module Kentaa
  module Api
    class Client
      def initialize(config)
        @config = config
      end

      def actions
        Kentaa::Api::Clients::Actions.new(@config)
      end

      def donation_forms
        Kentaa::Api::Clients::DonationForms.new(@config)
      end

      def donations
        Kentaa::Api::Clients::Donations.new(@config)
      end

      def manual_donations
        Kentaa::Api::Clients::ManualDonations.new(@config)
      end

      def newsletter_subscriptions
        Kentaa::Api::Clients::NewsletterSubscriptions.new(@config)
      end

      def projects
        Kentaa::Api::Clients::Projects.new(@config)
      end

      def recurring_donors
        Kentaa::Api::Clients::RecurringDonors.new(@config)
      end

      def segments
        Kentaa::Api::Clients::Segments.new(@config)
      end

      def sites
        Kentaa::Api::Clients::Sites.new(@config)
      end

      def teams
        Kentaa::Api::Clients::Teams.new(@config)
      end

      def users
        Kentaa::Api::Clients::Users.new(@config)
      end
    end
  end
end
