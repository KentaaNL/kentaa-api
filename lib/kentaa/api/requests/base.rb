# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Base
        attr_reader :request

        def initialize(request)
          @request = request
        end
      end
    end
  end
end
