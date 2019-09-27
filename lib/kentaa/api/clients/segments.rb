# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Segments < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          response = request.get("/segments", options)
          Kentaa::Api::Resources::Segments.new(config, response)
        end

        def get(id, options = {})
          response = request.get("/segments/#{id}", options)
          Kentaa::Api::Resources::Segment.new(config, response)
        end
      end
    end
  end
end
