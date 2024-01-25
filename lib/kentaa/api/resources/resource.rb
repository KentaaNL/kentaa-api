# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Resources
      class Resource < Base
        attr_accessor :id

        def initialize(config, id: nil, data: nil, options: {})
          super(config, options)

          if data
            @data = data || {}
            @id = @data.fetch(:id) if @data.key?(:id)
          elsif id
            @id = id
          end
        end

        def load
          super
          @id = data.fetch(:id) if data.key?(:id)

          self
        end

        def create(attributes)
          save(attributes)
        end

        def save(attributes)
          if id
            @response = update_resource(attributes)
          else
            @response = create_resource(attributes)
            @id = data.fetch(:id) if data.key?(:id)
          end

          self
        end

        def delete
          delete_resource

          nil
        end

        def created_at
          Time.parse(data[:created_at]) if data[:created_at]
        end

        def updated_at
          Time.parse(data[:updated_at]) if data[:updated_at]
        end

        private

        def create_resource(_attributes)
          raise NotImplementedError
        end

        def update_resource(_attributes)
          raise NotImplementedError
        end

        def delete_resource
          raise NotImplementedError
        end
      end
    end
  end
end
