# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Projects < List
        include Enumerable

        def each(&block)
          projects.each(&block)
        end

        private

        def load_resource
          request.get("/projects", options)
        end

        def projects
          @projects ||= begin
            projects = []

            if data
              data.each do |project|
                projects << Kentaa::Api::Resources::Project.new(config, data: project)
              end
            end

            projects
          end
        end
      end
    end
  end
end
