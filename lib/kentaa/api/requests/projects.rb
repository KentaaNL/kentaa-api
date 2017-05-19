module Kentaa
  module Api
    module Requests
      class Projects < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = http.get("/projects", options)
          Kentaa::Api::Responses::Projects.new(response)
        end

        def get(id)
          response = http.get("/projects/#{id}")
          Kentaa::Api::Responses::Project.new(response)
        end
      end
    end
  end
end
