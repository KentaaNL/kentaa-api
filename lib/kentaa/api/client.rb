# frozen_string_literal: true

module Kentaa
  module Api
    class Client
      def initialize(api_key, options = {})
        @http = Kentaa::Api::Http.new(api_key, options)
      end

      def actions
        Kentaa::Api::Requests::Actions.new(@http)
      end

      def donations
        Kentaa::Api::Requests::Donations.new(@http)
      end

      def newsletter_subscriptions
        Kentaa::Api::Requests::NewsletterSubscriptions.new(@http)
      end

      def projects
        Kentaa::Api::Requests::Projects.new(@http)
      end

      def segments
        Kentaa::Api::Requests::Segments.new(@http)
      end

      def sites
        Kentaa::Api::Requests::Sites.new(@http)
      end

      def teams
        Kentaa::Api::Requests::Teams.new(@http)
      end
    end
  end
end
