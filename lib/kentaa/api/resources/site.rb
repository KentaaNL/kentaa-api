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

        def public_id
          data[:public_id]
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

        def logos
          @logos ||= begin
            logos = []

            if data[:logos]
              data[:logos].map do |logo|
                logos << Kentaa::Api::Resources::Logo.new(logo)
              end
            end

            logos
          end
        end

        def external_reference
          data[:external_reference]
        end

        def background_image_url
          data[:background_image_url]
        end

        def sign_up_flow_background_image_url
          data[:sign_up_flow_background_image_url]
        end

        def theme
          @theme ||= Kentaa::Api::Resources::Theme.new(data[:theme])
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

        def orders
          @orders ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Order, endpoint_path: '/orders')
        end

        def activities
          @activities ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Activity, endpoint_path: '/activities')
        end

        private

        def load_resource
          request.get('/sites/current', options)
        end
      end
    end
  end
end
