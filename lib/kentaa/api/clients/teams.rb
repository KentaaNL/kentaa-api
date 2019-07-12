# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Teams < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          response = request.get("/teams", options)
          Kentaa::Api::Resources::Teams.new(config, response)
        end

        def get(id)
          response = request.get("/teams/#{id}")
          Kentaa::Api::Resources::Team.new(config, response)
        end
      end
    end
  end
end
