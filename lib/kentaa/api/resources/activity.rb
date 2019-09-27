# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Activity < Resource
        def name
          data[:name]
        end
      end
    end
  end
end
