# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class NewsletterSubscriptions < Base
        def all(options = {})
          newsletter_subscriptions = Kentaa::Api::Resources::NewsletterSubscriptions.new(config, options)
          newsletter_subscriptions.all
        end

        def list(options = {})
          newsletter_subscriptions = Kentaa::Api::Resources::NewsletterSubscriptions.new(config, options)
          newsletter_subscriptions.load
        end

        def get(id, options = {})
          newsletter_subscription = Kentaa::Api::Resources::NewsletterSubscription.new(config, options.merge(id: id))
          newsletter_subscription.load
        end
      end
    end
  end
end
