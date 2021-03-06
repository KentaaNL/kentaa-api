# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class DonationForm < Resource
        def object_key
          "DonationForm_#{id}"
        end

        def parent
          site
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def slug
          data[:slug]
        end

        def site_id
          data[:site_id]
        end

        def owner
          @owner ||= Kentaa::Api::Resources::User.new(config, data: data[:owner], options: options)
        end

        def title
          data[:title]
        end

        def description
          data[:description]
        end

        def total_amount
          BigDecimal(data[:total_amount])
        end

        def total_donations
          data[:total_donations]
        end

        def published?
          data[:published]
        end

        def visible?
          data[:visible]
        end

        def external_reference
          data[:external_reference]
        end

        def url
          data[:url]
        end

        def banners
          @banners ||= begin
            banners = []

            if data[:banners]
              data[:banners].each do |banner|
                banners << Kentaa::Api::Resources::Banner.new(banner)
              end
            end

            banners
          end
        end

        def donations
          @donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Donation, endpoint_path: "/donation-forms/#{id}/donations")
        end

        def manual_donations
          @manual_donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::ManualDonation, endpoint_path: "/donation-forms/#{id}/manual-donations")
        end

        def newsletter_subscriptions
          @newsletter_subscriptions ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::NewsletterSubscription, endpoint_path: "/donation-forms/#{id}/newsletter-subscriptions")
        end

        def recurring_donors
          @recurring_donors ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::RecurringDonor, endpoint_path: "/donation-forms/#{id}/recurring-donors")
        end

        private

        def load_resource
          request.get("/donation-forms/#{id}", options)
        end
      end
    end
  end
end
