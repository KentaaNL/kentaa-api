# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class NewsletterSubscriptions < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          response = request.get("/newsletter-subscriptions", options)
          Kentaa::Api::Resources::NewsletterSubscriptions.new(config, response)
        end

        def get(id, options = {})
          response = request.get("/newsletter-subscriptions/#{id}", options)
          Kentaa::Api::Resources::NewsletterSubscription.new(config, response)
        end
      end
    end
  end
end
