# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Avatar < Resource
        def avatar_url
          data[:avatar_url]
        end

        private

        def load_resource
          request.get("#{endpoint_path}/avatar", options)
        end

        def create_resource(attributes)
          io = attributes.fetch(:io)
          content_type = attributes.fetch(:content_type)

          request.post("#{endpoint_path}/avatar", options, io, content_type: content_type)
        end

        def delete_resource
          request.delete("#{endpoint_path}/avatar", options)
        end
      end
    end
  end
end
