module Kentaa
  module Api
    module Responses
      class NewsletterSubscriptions < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def initialize(response)
          super(response)
        end

        def each(&block)
          newsletter_subscriptions.each(&block)
        end

        private

        def newsletter_subscriptions
          @newsletter_subscriptions ||= begin
            newsletter_subscriptions = []

            if data[:newsletter_subscriptions]
              data[:newsletter_subscriptions].each do |newsletter_subscription|
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
