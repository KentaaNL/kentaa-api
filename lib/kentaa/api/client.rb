# frozen_string_literal: true

module Kentaa
  module Api
    class Client
      def initialize(api_key, options = {})
        @request = Kentaa::Api::Request.new(api_key, options)
      end

      def actions
        Kentaa::Api::Requests::Actions.new(@request)
      end

      def donations
        Kentaa::Api::Requests::Donations.new(@request)
      end

      def newsletter_subscriptions
        Kentaa::Api::Requests::NewsletterSubscriptions.new(@request)
      end

      def projects
        Kentaa::Api::Requests::Projects.new(@request)
      end

      def segments
        Kentaa::Api::Requests::Segments.new(@request)
      end

      def sites
        Kentaa::Api::Requests::Sites.new(@request)
      end

      def teams
        Kentaa::Api::Requests::Teams.new(@request)
      end

      def users
        Kentaa::Api::Requests::Users.new(@request)
      end
    end
  end
end
