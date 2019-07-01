# frozen_string_literal: true

require 'json'

module Kentaa
  module Api
    module Responses
      class Base
        attr_reader :data

        def initialize(data)
          @data = data || {}
        end

        class << self
          def build(response)
            body = parse_body(response.body)
            data = body[attribute_key]

            object = new(data)
            object.extend(Kentaa::Api::Responses::Response)
            object.response = response
            object.body = body
            object
          end

          private

          def parse_body(body)
            JSON.parse(body, symbolize_names: true)
          rescue JSON::ParserError => e
            {
              message: "Unable to parse JSON: #{e.message}"
            }
          end

          def attribute_key
            class_name = name.split("::").last
            class_name.gsub(/([^\^])([A-Z])/, '\1_\2').downcase.to_sym
          end
        end
      end
    end
  end
end
