# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Activity < Base
        include Kentaa::Api::Responses::Resource

        def name
          data[:name]
        end
      end
    end
  end
end
