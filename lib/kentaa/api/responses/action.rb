require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Responses
      class Action < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response[:action] || response)
        end

        def slug
          data[:slug]
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
          @owner ||= Kentaa::Api::Responses::Owner.new(data[:owner])
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
          BigDecimal.new(data[:total_amount])
        end

        def total_donations
          data[:total_donations]
        end

        def visible?
          data[:visible]
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
      end
    end
  end
end
