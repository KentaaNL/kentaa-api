# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Teams < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = request.get("/teams", options)
          Kentaa::Api::Responses::Teams.new(response)
        end

        def get(id)
          response = request.get("/teams/#{id}")
          Kentaa::Api::Responses::Team.new(response)
        end
      end
    end
  end
end
