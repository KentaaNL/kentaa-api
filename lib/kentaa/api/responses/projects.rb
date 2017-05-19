module Kentaa
  module Api
    module Responses
      class Projects < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def initialize(response)
          super(response)
        end

        def each(&block)
          projects.each(&block)
        end

        private

        def projects
          @projects ||= begin
            projects = []

            if data[:projects]
              data[:projects].each do |project|
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
