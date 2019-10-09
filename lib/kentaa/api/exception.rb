# frozen_string_literal: true

module Kentaa
  module Api
    class Exception < StandardError
    end

    class RequestError < Kentaa::Api::Exception
      attr_accessor :response

      def initialize(response)
        @response = response

        super(response.message)
      end

      def http_code
        response.http_code
      end
    end
  end
end
