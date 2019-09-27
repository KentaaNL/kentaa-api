# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Resources
      class Resource < Base
        attr_accessor :id

        def initialize(config, options = {})
          super(config, options)

          if options.key?(:data)
            @data = options.delete(:data) || {}
            @id = @data.fetch(:id) if @data.key?(:id)
          elsif options.key?(:id)
            @id = options.delete(:id)
          end
        end

        def created_at
          Time.parse(data[:created_at]) if data[:created_at]
        end

        def updated_at
          Time.parse(data[:updated_at]) if data[:updated_at]
        end
      end
    end
  end
end
