module Kentaa
  module Api
    module Responses
      class NewsletterSubscription < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response)
        end

        def segment_id
          data[:segment_id]
        end

        def project_id
          data[:project_id]
        end

        def email
          data[:email]
        end

        def locale
          data[:locale]
        end

        def subscription_url
          data[:subscription_url]
        end
      end
    end
  end
end
