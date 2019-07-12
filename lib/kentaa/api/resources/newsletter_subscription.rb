# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class NewsletterSubscription < Base
        include Kentaa::Api::Resources::Resource

        def object_key
          "NewsletterSubscription_#{id}"
        end

        def entity
          if project_id
            client = Kentaa::Api::Clients::Projects.new(config)
            client.get(project_id)
          elsif segment_id
            client = Kentaa::Api::Clients::Segments.new(config)
            client.get(segment_id)
          else
            client = Kentaa::Api::Clients::Sites.new(config)
            client.current
          end
        end

        def first_name
          data[:first_name]
        end

        def infix
          data[:infix]
        end

        def last_name
          data[:last_name]
        end

        def name
          [first_name, infix, last_name].compact.join(" ")
        end

        def site_id
          data[:site_id]
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

        def consent
          @consent ||= Kentaa::Api::Resources::Consent.new(config, data[:consent]) if data[:consent]
        end
      end
    end
  end
end
