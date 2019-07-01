# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class NewsletterSubscriptions < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def each(&block)
          newsletter_subscriptions.each(&block)
        end

        private

        def newsletter_subscriptions
          @newsletter_subscriptions ||= begin
            newsletter_subscriptions = []

            if data
              data.each do |newsletter_subscription|
                newsletter_subscriptions << Kentaa::Api::Responses::NewsletterSubscription.new(newsletter_subscription)
              end
            end

            newsletter_subscriptions
          end
        end
      end
    end
  end
end
