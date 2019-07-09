# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Responses
      class Action < Base
        include Kentaa::Api::Responses::Resource

        def object_key
          "Action_#{id}"
        end

        def parent
          if team_id
            Team.new(id: team_id)
          elsif project_id
            Project.new(id: project_id)
          elsif segment_id
            Segment.new(id: segment_id)
          else
            Site.new(id: site_id)
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
          @owner ||= Kentaa::Api::Responses::User.new(data[:owner])
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
          @activity ||= Kentaa::Api::Responses::Activity.new(data[:activity])
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
          @registration_fee ||= Kentaa::Api::Responses::RegistrationFee.new(data[:registration_fee])
        end

        def location
          @location ||= Kentaa::Api::Responses::Location.new(data[:location])
        end

        def photos
          @photos ||= begin
            photos = []

            if data[:photos]
              data[:photos].each do |photo|
                photos << Kentaa::Api::Responses::Photo.new(photo)
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
                videos << Kentaa::Api::Responses::Video.new(video)
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
                questions << Kentaa::Api::Responses::Question.new(question)
              end
            end

            questions
          end
        end

        def consent
          @consent ||= Kentaa::Api::Responses::Consent.new(data[:consent]) if data[:consent]
        end

        def external_reference
          data[:external_reference]
        end
      end
    end
  end
end
