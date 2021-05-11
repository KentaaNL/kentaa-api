# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Performances < List
        include Enumerable

        def initialize(config, options = {})
          @action_id = options.delete(:action_id)
          super(config, options)
        end

        def each(&block)
          performances.each(&block)
        end

        def create(attributes = {})
          performance = Kentaa::Api::Resources::Performance.new(config, options: options.merge(action_id: @action_id))
          performance.save(attributes)
        end

        private

        def load_resource
          request.get("/actions/#{@action_id}/performances", options)
        end

        def performances
          @performances ||= begin
            performances = []

            if data
              data.each do |performance|
                performances << Kentaa::Api::Resources::Performance.new(config, data: performance, options: options)
              end
            end

            performances
          end
        end
      end
    end
  end
end
