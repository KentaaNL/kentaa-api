# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Teams < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def each(&block)
          teams.each(&block)
        end

        private

        def teams
          @teams ||= begin
            teams = []

            if data
              data.each do |team|
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
