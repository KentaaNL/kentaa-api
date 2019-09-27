# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Sites < Base
        def current(options = {})
          response = request.get("/sites/current", options)
          Kentaa::Api::Resources::Site.new(config, response)
        end
      end
    end
  end
end
