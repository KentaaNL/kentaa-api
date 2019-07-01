# frozen_string_literal: true

require 'json'

module Kentaa
  module Api
    module Responses
      class Base
        attr_reader :response, :body, :data

        def initialize(response)
          if response.respond_to?(:body)
            @response = response
            @body = parse_body(response.body)
            @data = body[attribute_key]
          else
            @body = response
            @data = body
          end
        end

        def success?
          (response_code == 200 || response_code == 201) && !@invalid
        end

        def error?
          !success?
        end

        def message
          body[:message]
        end

        private

        def response_code
          response.code.to_i if response
        end

        def parse_body(body)
          JSON.parse(body, symbolize_names: true)
        rescue JSON::ParserError => ex
          @invalid = true

          {
            message: "Unable to parse JSON: #{ex.message}"
          }
        end

        def attribute_key
          class_name = self.class.name.split("::").last
          class_name.gsub(/([^\^])([A-Z])/, '\1_\2').downcase.to_sym
        end
      end
    end
  end
end
