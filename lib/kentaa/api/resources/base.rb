# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Base
        attr_reader :config, :options

        def initialize(config, options = {})
          @config = config
          @options = options
        end

        def load
          @response ||= load_resource

          self
        end

        def loaded?
          !@response.nil?
        end

        private

        def attribute_key
          class_name = self.class.name.split('::').last
          class_name.gsub(/([^\^])([A-Z])/, '\1_\2').downcase.to_sym
        end

        def load_resource
          raise NotImplementedError
        end

        def data
          @data ||= begin
            load unless loaded?

            @response.body[attribute_key] || {}
          end
        end

        def body
          @body ||= begin
            load unless loaded?

            @response.body
          end
        end

        def request
          @request ||= Kentaa::Api::Request.new(config)
        end
      end
    end
  end
end
