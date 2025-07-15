# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Segment < Resource
        def object_key
          "Segment_#{id}"
        end

        def parent
          site
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def public_id
          data[:public_id]
        end

        def site_id
          data[:site_id]
        end

        def subdomain
          data[:subdomain]
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

        def actions
          @actions ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Action, endpoint_path: "/segments/#{id}/actions")
        end

        def teams
          @teams ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Team, endpoint_path: "/segments/#{id}/teams")
        end

        def projects
          @projects ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Project, endpoint_path: "/segments/#{id}/projects")
        end

        def donations
          @donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Donation, endpoint_path: "/segments/#{id}/donations")
        end

        def manual_donations
          @manual_donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::ManualDonation, endpoint_path: "/segments/#{id}/manual-donations")
        end

        def newsletter_subscriptions
          @newsletter_subscriptions ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::NewsletterSubscription, endpoint_path: "/segments/#{id}/newsletter-subscriptions")
        end

        def activities
          @activities ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Activity, endpoint_path: "/segments/#{id}/activities")
        end

        def news
          @news ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::News, endpoint_path: "/segments/#{id}/news")
        end

        def orders
          @orders ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Order, endpoint_path: "/segments/#{id}/orders")
        end

        private

        def load_resource
          request.get("/segments/#{id}", options)
        end
      end
    end
  end
end
