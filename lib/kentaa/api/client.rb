# frozen_string_literal: true

module Kentaa
  module Api
    class Client
      def initialize(options = {})
        @config = Kentaa::Api::Config.new(options)
      end

      def actions(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::Action, endpoint_path: '/actions'))
      end

      def companies(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::Company, endpoint_path: '/companies'))
      end

      def donations(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::Donation, endpoint_path: '/donations'))
      end

      def donation_forms(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::DonationForm, endpoint_path: '/donation-forms'))
      end

      def manual_donations(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::ManualDonation, endpoint_path: '/manual-donations'))
      end

      def newsletter_subscriptions(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::NewsletterSubscription, endpoint_path: '/newsletter-subscriptions'))
      end

      def projects(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::Project, endpoint_path: '/projects'))
      end

      def recurring_donors(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::RecurringDonor, endpoint_path: '/recurring-donors'))
      end

      def segments(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::Segment, endpoint_path: '/segments'))
      end

      def sites(options = {})
        Kentaa::Api::Resources::Sites.new(@config, options)
      end

      def teams(options = {})
        Kentaa::Api::Resources::List.new(@config, options.merge(resource_class: Kentaa::Api::Resources::Team, endpoint_path: '/teams'))
      end

      def users(options = {})
        Kentaa::Api::Resources::Users.new(@config, options)
      end
    end
  end
end
