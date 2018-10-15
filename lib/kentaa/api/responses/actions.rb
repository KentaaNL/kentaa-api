# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Actions < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def initialize(response)
          super(response)
        end

        def each(&block)
          actions.each(&block)
        end

        private

        def actions
          @actions ||= begin
            actions = []

            if data[:actions]
              data[:actions].each do |action|
                actions << Kentaa::Api::Responses::Action.new(action)
              end
            end

            actions
          end
        end
      end
    end
  end
end
