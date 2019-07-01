# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      module Status
        attr_accessor :response

        def success?
          (response.code == 200 || response.code == 201) && !message
        end

        def error?
          !success?
        end

        def body
          response.body
        end

        def message
          body[:message] if body
        end
      end
    end
  end
end
