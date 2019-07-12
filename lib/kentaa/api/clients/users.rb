# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Users < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          response = request.get("/users", options)
          Kentaa::Api::Resources::Users.new(config, response)
        end

        def get(id)
          response = request.get("/users/#{id}")
          Kentaa::Api::Resources::User.new(config, response)
        end
      end
    end
  end
end
