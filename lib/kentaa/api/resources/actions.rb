# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Actions < List
        include Enumerable

        def each(&block)
          actions.each(&block)
        end

        def create(attributes = {})
          action = Kentaa::Api::Resources::Action.new(config, options: options)
          action.save(attributes)
        end

        private

        def load_resource
          request.get("/actions", options)
        end

        def actions
          @actions ||= begin
            actions = []

            if data
              data.each do |action|
                actions << Kentaa::Api::Resources::Action.new(config, data: action, options: options)
              end
            end

            actions
          end
        end
      end
    end
  end
end
