# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Project < Resource
        def object_key
          "Project_#{id}"
        end

        def parent
          if segment_id
            Kentaa::Api::Resources::Segment.new(config, id: segment_id, options: options)
          else
            Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
          end
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def public_id
          data[:public_id]
        end

        def slug
          data[:slug]
        end

        def site_id
          data[:site_id]
        end

        def segment_id
          data[:segment_id]
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

        def target_amount_achieved?
          data[:target_amount_achieved]
        end

        def visible?
          data[:visible]
        end

        def countable?
          data[:countable]
        end

        def closed?
          data[:closed]
        end

        def ended?
          data[:ended]
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

        def has_target_amount?
          data[:has_target_amount]
        end

        def location
          @location ||= Kentaa::Api::Resources::Location.new(data[:location]) if data[:location]
        end

        def photos
          @photos ||= begin
            photos = []

            if data[:photos]
              data[:photos].each do |photo|
                photos << Kentaa::Api::Resources::Photo.new(photo)
              end
            end

            photos
          end
        end

        def videos
          @videos ||= begin
            videos = []

            if data[:videos]
              data[:videos].each do |video|
                videos << Kentaa::Api::Resources::Video.new(video)
              end
            end

            videos
          end
        end

        def questions
          @questions ||= begin
            questions = []

            if data[:questions]
              data[:questions].each do |question|
                questions << Kentaa::Api::Resources::Question.new(question)
              end
            end

            questions
          end
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

        def contact
          @contact ||= Kentaa::Api::Resources::Contact.new(data[:contact]) if data[:contact]
        end

        def external_reference
          data[:external_reference]
        end

        def actions
          @actions ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Action, endpoint_path: "/projects/#{id}/actions")
        end

        def teams
          @teams ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Team, endpoint_path: "/projects/#{id}/teams")
        end

        def donations
          @donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Donation, endpoint_path: "/projects/#{id}/donations")
        end

        def manual_donations
          @manual_donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::ManualDonation, endpoint_path: "/projects/#{id}/manual-donations")
        end

        def newsletter_subscriptions
          @newsletter_subscriptions ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::NewsletterSubscription, endpoint_path: "/projects/#{id}/newsletter-subscriptions")
        end

        def activities
          @activities ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Activity, endpoint_path: "/projects/#{id}/activities")
        end

        def news
          @news ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::News, endpoint_path: "/projects/#{id}/news")
        end

        private

        def load_resource
          request.get("/projects/#{id}", options)
        end
      end
    end
  end
end
