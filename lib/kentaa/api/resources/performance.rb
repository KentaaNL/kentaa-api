# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Performance < Resource
        def object_key
          "ActionPerformance_#{id}"
        end

        def action_id
          data[:action_id]
        end

        def action
          Kentaa::Api::Resources::Action.new(config, id: action_id, options: options)
        end

        def title
          data[:title]
        end

        def description
          data[:description]
        end

        def performance_type
          data[:performance_type]
        end

        def performance_at
          Time.parse(data[:performance_at])
        end

        def distance
          BigDecimal(data[:distance])
        end

        def unit
          data[:unit]
        end

        private

        def load_resource
          request.get("#{endpoint_path}/#{id}", options)
        end

        def create_resource(attributes)
          request.post(endpoint_path, options, attributes)
        end

        def update_resource(attributes)
          request.patch("#{endpoint_path}/#{id}", options, attributes)
        end

        def delete_resource
          request.delete("#{endpoint_path}/#{id}", options)
        end
      end
    end
  end
end
