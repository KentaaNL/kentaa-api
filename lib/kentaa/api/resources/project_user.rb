# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class ProjectUser < Resource
        def project_id
          data[:project_id]
        end

        def role
          data[:role]
        end

        def user_id
          data[:user_id]
        end

        private

        def create_resource(attributes)
          request.post(endpoint_path, options, attributes)
        end

        def delete_resource
          request.delete("#{endpoint_path}/#{id}", options)
        end
      end
    end
  end
end
