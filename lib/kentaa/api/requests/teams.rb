# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Teams < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = request.get("/teams", options)
          Kentaa::Api::Responses::Teams.build(response)
        end

        def get(id)
          response = request.get("/teams/#{id}")
          Kentaa::Api::Responses::Team.build(response)
        end
      end
    end
  end
end
