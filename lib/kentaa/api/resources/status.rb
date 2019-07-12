# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      module Status
        attr_accessor :response

        def success?
          response.success?
        end

        def error?
          response.error?
        end

        def body
          response.body
        end

        def message
          response.message
        end
      end
    end
  end
end
