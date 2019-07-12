# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Actions < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          response = request.get("/actions", options)
          Kentaa::Api::Resources::Actions.new(config, response)
        end

        def get(id)
          response = request.get("/actions/#{id}")
          Kentaa::Api::Resources::Action.new(config, response)
        end
      end
    end
  end
end
