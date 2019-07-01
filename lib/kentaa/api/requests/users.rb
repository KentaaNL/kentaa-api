# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Users < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = request.get("/users", options)
          Kentaa::Api::Responses::Users.new(response)
        end

        def get(id)
          response = request.get("/users/#{id}")
          Kentaa::Api::Responses::User.new(response)
        end
      end
    end
  end
end
