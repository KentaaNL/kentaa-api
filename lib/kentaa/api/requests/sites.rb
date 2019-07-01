# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Sites < Base
        def current
          response = request.get("/sites/current")
          Kentaa::Api::Responses::Site.new(response)
        end
      end
    end
  end
end
