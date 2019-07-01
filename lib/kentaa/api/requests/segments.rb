# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Segments < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = request.get("/segments", options)
          Kentaa::Api::Responses::Segments.new(response)
        end

        def get(id)
          response = request.get("/segments/#{id}")
          Kentaa::Api::Responses::Segment.new(response)
        end
      end
    end
  end
end
