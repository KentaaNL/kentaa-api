# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Projects < Base
        def all(options = {})
          projects = Kentaa::Api::Resources::Projects.new(config, options)
          projects.all
        end

        def list(options = {})
          projects = Kentaa::Api::Resources::Projects.new(config, options)
          projects.load
        end

        def get(id, options = {})
          project = Kentaa::Api::Resources::Project.new(config, id: id, options: options)
          project.load
        end
      end
    end
  end
end
