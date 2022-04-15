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
            Kentaa::Api::Resources::Project.new(config, id: project_id, options: options)
          elsif segment_id
            Kentaa::Api::Resources::Segment.new(config, id: segment_id, options: options)
          elsif donation_form_id
            Kentaa::Api::Resources::DonationForm.new(config, id: donation_form_id, options: options)
          else
            Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
          end
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
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
          [first_name, infix, last_name].reject { |s| s.to_s.empty? }.join(' ')
        end

        def site_id
          data[:site_id]
        end

        def donation_form_id
          data[:donation_form_id]
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
          Kentaa::Api::Deprecation.warn('#consent is deprecated. Please use #consents instead.', caller)

          @consent ||= Kentaa::Api::Resources::Consent.new(data[:consent]) if data[:consent]
        end

        def consents
          @consents ||= begin
            consents = []

            if data[:consents]
              data[:consents].each do |consent|
                consents << Kentaa::Api::Resources::Consent.new(consent)
              end
            end

            consents
          end
        end

        private

        def load_resource
          request.get("/newsletter-subscriptions/#{id}", options)
        end
      end
    end
  end
end
