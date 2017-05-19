module Kentaa
  module Api
    module Requests
      class Base
        attr_reader :http

        def initialize(http)
          @http = http
        end
      end
    end
  end
end
