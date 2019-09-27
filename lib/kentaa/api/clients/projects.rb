# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Projects < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          response = request.get("/projects", options)
          Kentaa::Api::Resources::Projects.new(config, response)
        end

        def get(id, options = {})
          response = request.get("/projects/#{id}", options)
          Kentaa::Api::Resources::Project.new(config, response)
        end
      end
    end
  end
end
