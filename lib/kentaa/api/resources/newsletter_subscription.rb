# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class NewsletterSubscription < Resource
        def object_key
          "NewsletterSubscription_#{id}"
        end

        def entity
          if project_id
            Kentaa::Api::Resources::Project.new(config, id: project_id)
          elsif segment_id
            Kentaa::Api::Resources::Segment.new(config, id: segment_id)
          else
            Kentaa::Api::Resources::Site.new(config, id: site_id)
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
          [first_name, infix, last_name].reject { |s| s.to_s.empty? }.join(" ")
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
          @consent ||= Kentaa::Api::Resources::Consent.new(config, data: data[:consent]) if data[:consent]
        end

        protected

        def load_resource(options)
          request.get("/newsletter-subscriptions/#{id}", options)
        end
      end
    end
  end
end
