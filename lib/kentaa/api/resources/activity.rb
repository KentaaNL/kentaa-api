# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Activity
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def id
          data[:id]
        end

        def name
          data[:name]
        end
      end
    end
  end
end
