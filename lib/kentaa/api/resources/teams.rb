# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Teams < Base
        include Enumerable
        include Kentaa::Api::Resources::Pagination

        def each(&block)
          teams.each(&block)
        end

        private

        def teams
          @teams ||= begin
            teams = []

            if data
              data.each do |team|
                teams << Kentaa::Api::Resources::Team.new(config, team)
              end
            end

            teams
          end
        end
      end
    end
  end
end