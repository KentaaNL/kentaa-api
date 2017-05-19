module Kentaa
  module Api
    module Responses
      class Teams < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def initialize(response)
          super(response)
        end

        def each(&block)
          teams.each(&block)
        end

        private

        def teams
          @teams ||= begin
            teams = []

            if data[:teams]
              data[:teams].each do |team|
                teams << Kentaa::Api::Responses::Team.new(team)
              end
            end

            teams
          end
        end
      end
    end
  end
end
