# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Teams < List
        include Enumerable

        def each(&block)
          teams.each(&block)
        end

        protected

        def load_resource(options)
          request.get("/teams", options)
        end

        private

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
