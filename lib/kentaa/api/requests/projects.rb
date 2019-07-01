# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Projects < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = request.get("/projects", options)
          Kentaa::Api::Responses::Projects.build(response)
        end

        def get(id)
          response = request.get("/projects/#{id}")
          Kentaa::Api::Responses::Project.build(response)
        end
      end
    end
  end
end
