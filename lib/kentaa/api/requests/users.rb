# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Users < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = request.get("/users", options)
          Kentaa::Api::Responses::Users.build(response)
        end

        def get(id)
          response = request.get("/users/#{id}")
          Kentaa::Api::Responses::User.build(response)
        end
      end
    end
  end
end
