module Kentaa
  module Api
    module Requests
      class Actions < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = http.get("/actions", options)
          Kentaa::Api::Responses::Actions.new(response)
        end

        def get(id)
          response = http.get("/actions/#{id}")
          Kentaa::Api::Responses::Action.new(response)
        end
      end
    end
  end
end
