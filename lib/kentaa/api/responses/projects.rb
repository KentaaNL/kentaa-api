# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Projects < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def each(&block)
          projects.each(&block)
        end

        private

        def projects
          @projects ||= begin
            projects = []

            if data
              data.each do |project|
                projects << Kentaa::Api::Responses::Project.new(project)
              end
            end

            projects
          end
        end
      end
    end
  end
end
