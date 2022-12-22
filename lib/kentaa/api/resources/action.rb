# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Action < Resource
        WHO_TYPE_OWNER = 'owner'
        WHO_TYPE_OTHER = 'other'

        def object_key
          "Action_#{id}"
        end

        def parent
          if team_id
            Kentaa::Api::Resources::Team.new(config, id: team_id, options: options)
          elsif company_id
            Kentaa::Api::Resources::Company.new(config, id: company_id, options: options)
          elsif project_id
            Kentaa::Api::Resources::Project.new(config, id: project_id, options: options)
          elsif segment_id
            Kentaa::Api::Resources::Segment.new(config, id: segment_id, options: options)
          else
            Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
          end
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

        def segment_id
          data[:segment_id]
        end

        def project_id
          data[:project_id]
        end

        def company_id
          data[:company_id]
        end

        def team_id
          data[:team_id]
        end

        def owner
          @owner ||= Kentaa::Api::Resources::User.new(config, data: data[:owner], options: options)
        end

        def team_captain?
          data.fetch(:team_captain, false)
        end

        def who_type
          data[:who_type]
        end

        def owner?
          who_type == WHO_TYPE_OWNER
        end

        def other?
          who_type == WHO_TYPE_OTHER
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

        def avatar_url
          data[:avatar_url]
        end

        def name
          [first_name, infix, last_name].reject { |s| s.to_s.empty? }.join(' ')
        end

        def fundraiser_page?
          data[:fundraiser_page]
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

        def activity
          @activity ||= Kentaa::Api::Resources::Activity.new(data[:activity]) if data[:activity]
        end

        def previous_participations
          data[:previous_participations]
        end

        def url
          data[:url]
        end

        def donate_url
          data[:donate_url]
        end

        def registration_fee
          @registration_fee ||= Kentaa::Api::Resources::RegistrationFee.new(data[:registration_fee])
        end

        def location
          @location ||= Kentaa::Api::Resources::Location.new(data[:location])
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

        def external_reference
          data[:external_reference]
        end

        def donations
          @donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Donation, endpoint_path: "/actions/#{id}/donations")
        end

        def manual_donations
          @manual_donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::ManualDonation, endpoint_path: "/actions/#{id}/manual-donations")
        end

        def performances(options = {})
          @performances ||= Kentaa::Api::Resources::List.new(config, options.merge(resource_class: Kentaa::Api::Resources::Performance, endpoint_path: "/actions/#{id}/performances"))
        end

        private

        def load_resource
          request.get("/actions/#{id}", options)
        end

        def create_resource(attributes)
          request.post('/actions', options, attributes)
        end

        def update_resource(attributes)
          request.patch("/actions/#{id}", options, attributes)
        end
      end
    end
  end
end
