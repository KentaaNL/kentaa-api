# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Action < Base
        include Kentaa::Api::Resources::Resource

        def object_key
          "Action_#{id}"
        end

        def parent
          if team_id
            client = Kentaa::Api::Clients::Teams.new(config)
            client.get(team_id)
          elsif project_id
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

        def team_id
          data[:team_id]
        end

        def owner
          @owner ||= Kentaa::Api::Resources::User.new(config, data[:owner])
        end

        def team_captain?
          data[:team_captain]
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
          [first_name, infix, last_name].compact.join(" ")
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
          @activity ||= Kentaa::Api::Resources::Activity.new(config, data[:activity])
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
          @registration_fee ||= Kentaa::Api::Resources::RegistrationFee.new(config, data[:registration_fee])
        end

        def location
          @location ||= Kentaa::Api::Resources::Location.new(config, data[:location])
        end

        def photos
          @photos ||= begin
            photos = []

            if data[:photos]
              data[:photos].each do |photo|
                photos << Kentaa::Api::Resources::Photo.new(config, photo)
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
                videos << Kentaa::Api::Resources::Video.new(config, video)
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
                questions << Kentaa::Api::Resources::Question.new(config, question)
              end
            end

            questions
          end
        end

        def consent
          @consent ||= Kentaa::Api::Resources::Consent.new(config, data[:consent]) if data[:consent]
        end

        def external_reference
          data[:external_reference]
        end
      end
    end
  end
end
