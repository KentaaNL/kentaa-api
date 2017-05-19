module Kentaa
  module Api
    module Requests
      class Segments < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = http.get("/segments", options)
          Kentaa::Api::Responses::Segments.new(response)
        end

        def get(id)
          response = http.get("/segments/#{id}")
          Kentaa::Api::Responses::Segment.new(response)
        end
      end
    end
  end
end
