# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Resources
      class News < Resource
        def object_key
          "News_#{id}"
        end

        def public_id
          data[:public_id]
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def title
          data[:title]
        end

        def content
          data[:content]
        end

        def labels
          data[:labels]
        end

        def publish_state
          data[:publish_state]
        end

        def publish_at
          Time.parse(data[:publish_at]) if data[:publish_at]
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

        private

        def load_resource
          request.get("/news/#{id}", options)
        end
      end
    end
  end
end
