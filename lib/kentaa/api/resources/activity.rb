# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Activity < Base
        include Kentaa::Api::Resources::Resource

        def name
          data[:name]
        end
      end
    end
  end
end
