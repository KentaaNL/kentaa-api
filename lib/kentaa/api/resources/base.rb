# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Base
        attr_reader :config, :options, :resource_class, :endpoint_path

        def initialize(config, options = {})
          @config = config
          @options = options
          @resource_class = options.delete(:resource_class) || self.class
          @endpoint_path = options.delete(:endpoint_path)
        end

        class << self
          def attribute_key
            class_name = name.split('::').last
            class_name.gsub(/([^\^])([A-Z])/, '\1_\2').downcase
          end
        end

        def load
          @response ||=
            if block_given?
              yield
            else
              load_resource
            end

          self
        end

        def loaded?
          !@response.nil?
        end

        private

        def attribute_key
          self.class.attribute_key
        end

        def load_resource
          raise NotImplementedError
        end

        def data
          @data ||= begin
            load unless loaded?

            @response.body[attribute_key.to_sym] || {}
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
