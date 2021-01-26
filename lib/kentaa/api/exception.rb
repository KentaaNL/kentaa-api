# frozen_string_literal: true

module Kentaa
  module Api
    class Exception < StandardError
    end

    class RequestError < Kentaa::Api::Exception
      attr_accessor :response

      def initialize(response)
        @response = response
      end

      def errors
        response.errors
      end

      def http_code
        response.http_code
      end

      def to_s
        "#{response.http_code}: #{response.message}"
      end
    end
  end
end
