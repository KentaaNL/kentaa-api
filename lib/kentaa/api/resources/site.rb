# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Site < Resource
        def object_key
          "Site_#{id}"
        end

        def host
          data[:host]
        end

        def name
          data[:name]
        end

        def title
          data[:title]
        end

        def description
          data[:description]
        end

        def target_amount
          data[:target_amount]
        end

        def total_amount
          BigDecimal(data[:total_amount])
        end

        def total_donations
          data[:total_donations]
        end

        def end_date
          Time.parse(data[:end_date]) if data[:end_date]
        end

        def url
          data[:url]
        end

        def donate_url
          data[:donate_url]
        end

        def video_url
          data[:video_url]
        end

        def owner_name
          data[:owner_name]
        end

        def owner_email
          data[:owner_email]
        end

        def default_currency
          data[:default_currency]
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

        def external_reference
          data[:external_reference]
        end

        def donations
          @donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Donation, endpoint_path: '/donations')
        end

        def manual_donations
          @manual_donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::ManualDonation, endpoint_path: '/manual-donations')
        end

        def newsletter_subscriptions
          @newsletter_subscriptions ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::NewsletterSubscription, endpoint_path: '/newsletter-subscriptions')
        end

        private

        def load_resource
          request.get('/sites/current', options)
        end
      end
    end
  end
end
