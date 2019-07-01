# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      module Response
        attr_accessor :response, :body

        def success?
          (response_code == 200 || response_code == 201) && !message
        end

        def error?
          !success?
        end

        def message
          body[:message] if body
        end

        private

        def response_code
          response.code.to_i if response
        end
      end
    end
  end
end
