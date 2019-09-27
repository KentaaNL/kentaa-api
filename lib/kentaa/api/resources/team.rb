# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Team < Base
        include Kentaa::Api::Resources::Resource

        def object_key
          "Team_#{id}"
        end

        def parent
          if project_id
            Project.new(config, id: project_id)
          elsif segment_id
            Segment.new(config, id: segment_id)
          else
            Site.new(config, id: site_id)
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

        def owner
          @owner ||= Kentaa::Api::Resources::User.new(config, data[:owner])
        end

        def members
          @members ||= begin
            members = []

            if data[:members]
              data[:members].each do |member|
                members << Kentaa::Api::Resources::Action.new(config, member)
              end
            end

            members
          end
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

        def external_reference
          data[:external_reference]
        end
      end
    end
  end
end
