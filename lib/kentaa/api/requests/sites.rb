module Kentaa
  module Api
    module Requests
      class Sites < Base
        def current
          response = http.get("/sites/current")
          Kentaa::Api::Responses::Site.new(response)
        end
      end
    end
  end
end
