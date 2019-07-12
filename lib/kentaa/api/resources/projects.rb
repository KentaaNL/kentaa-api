# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Projects < Base
        include Enumerable
        include Kentaa::Api::Resources::Pagination

        def each(&block)
          projects.each(&block)
        end

        private

        def projects
          @projects ||= begin
            projects = []

            if data
              data.each do |project|
                projects << Kentaa::Api::Resources::Project.new(config, project)
              end
            end

            projects
          end
        end
      end
    end
  end
end
