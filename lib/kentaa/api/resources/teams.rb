# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Teams < List
        include Enumerable

        def each(&block)
          teams.each(&block)
        end

        private

        def load_resource
          request.get("/teams", options)
        end

        def teams
          @teams ||= begin
            teams = []

            if data
              data.each do |team|
                teams << Kentaa::Api::Resources::Team.new(config, data: team)
              end
            end

            teams
          end
        end
      end
    end
  end
end
