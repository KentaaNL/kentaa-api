module Kentaa
  module Api
    module Requests
      class NewsletterSubscriptions < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = http.get("/newsletter-subscriptions", options)
          Kentaa::Api::Responses::NewsletterSubscriptions.new(response)
        end
      end
    end
  end
end
