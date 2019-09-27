# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Projects < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          projects = Kentaa::Api::Resources::Projects.new(config, options)
          projects.load
        end

        def get(id, options = {})
          project = Kentaa::Api::Resources::Project.new(config, options.merge(id: id))
          project.load
        end
      end
    end
  end
end
