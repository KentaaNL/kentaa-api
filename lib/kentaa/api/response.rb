# frozen_string_literal: true

require 'json'

module Kentaa
  module Api
    class Response
      SUCCESS_CODES = [200, 201, 204].freeze

      attr_reader :response, :body

      def initialize(response)
        @response = response
        @body = response.body ? parse_body(response.body) : {}
      end

      def success?
        SUCCESS_CODES.include?(http_code) && !message
      end

      def error?
        !success?
      end

      def http_code
        response.code.to_i
      end

      def request_uri
        response.uri
      end

      def message
        body[:message]
      end

      def errors
        @errors ||= begin
          errors = []

          if body[:errors]
            body[:errors].each do |error|
              errors << Kentaa::Api::Resources::Error.new(error)
            end
          end

          errors
        end
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
