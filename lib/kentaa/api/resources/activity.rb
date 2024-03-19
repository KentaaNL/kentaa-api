# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Activity < Resource
        def object_key
          "Activity_#{id}"
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def site_id
          data[:site_id]
        end

        def name
          data[:name]
        end

        def sign_up_limit
          data[:sign_up_limit]
        end

        def sign_up_count
          data[:sign_up_count]
        end

        private

        def load_resource
          request.get("#{endpoint_path}/#{id}", options)
        end
      end
    end
  end
end
