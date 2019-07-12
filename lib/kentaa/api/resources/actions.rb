# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Actions < Base
        include Enumerable
        include Kentaa::Api::Resources::Pagination

        def each(&block)
          actions.each(&block)
        end

        private

        def actions
          @actions ||= begin
            actions = []

            if data
              data.each do |action|
                actions << Kentaa::Api::Resources::Action.new(config, action)
              end
            end

            actions
          end
        end
      end
    end
  end
end
