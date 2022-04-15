# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class PerformancePhoto < Resource
        class << self
          def attribute_key
            'photo'
          end
        end

        def object_key
          "ActionPerformancePhoto_#{id}"
        end

        def image_url
          data[:image_url]
        end

        private

        def load_resource
          request.get("#{endpoint_path}/#{id}", options)
        end

        def create_resource(attributes)
          io = attributes.fetch(:io)
          content_type = attributes.fetch(:content_type)

          request.post(endpoint_path, options, io, content_type: content_type)
        end
      end
    end
  end
end
