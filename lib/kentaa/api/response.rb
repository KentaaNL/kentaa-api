# frozen_string_literal: true

require 'json'

module Kentaa
  module Api
    class Response
      attr_reader :response, :body

      def initialize(response)
        @response = response
        @body = parse_body(response.body)
      end

      def success?
        (http_code == 200 || http_code == 201) && !message
      end

      def error?
        !success?
      end

      def http_code
        response.code.to_i
      end

      def message
        body[:message]
      end

      private

      def parse_body(body)
        JSON.parse(body, symbolize_names: true)
      rescue JSON::ParserError => e
        {
          message: "Unable to parse JSON: #{e.message}"
        }
      end
    end
  end
end
