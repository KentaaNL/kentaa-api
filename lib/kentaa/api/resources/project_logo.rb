# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class ProjectLogo < Resource
        class << self
          def attribute_key
            'logo'
          end
        end

        def logo_url
          data[:logo_url]
        end

        private

        def load_resource
          request.get("#{endpoint_path}/logo", options)
        end

        def create_resource(attributes)
          io = attributes.fetch(:io)
          content_type = attributes.fetch(:content_type)

          request.post("#{endpoint_path}/logo", options, io, content_type: content_type)
        end

        def delete_resource
          request.delete("#{endpoint_path}/logo", options)
        end
      end
    end
  end
end
