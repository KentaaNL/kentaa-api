# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class NewsletterSubscriptions < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = request.get("/newsletter-subscriptions", options)
          Kentaa::Api::Responses::NewsletterSubscriptions.build(response)
        end

        def get(id)
          response = request.get("/newsletter-subscriptions/#{id}")
          Kentaa::Api::Responses::NewsletterSubscription.build(response)
        end
      end
    end
  end
end
