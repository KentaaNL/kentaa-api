# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class NewsletterSubscriptions < List
        include Enumerable

        def each(&block)
          newsletter_subscriptions.each(&block)
        end

        protected

        def load_resource(options)
          request.get("/newsletter-subscriptions", options)
        end

        private

        def newsletter_subscriptions
          @newsletter_subscriptions ||= begin
            newsletter_subscriptions = []

            if data
              data.each do |newsletter_subscription|
                newsletter_subscriptions << Kentaa::Api::Resources::NewsletterSubscription.new(config, data: newsletter_subscription)
              end
            end

            newsletter_subscriptions
          end
        end
      end
    end
  end
end
