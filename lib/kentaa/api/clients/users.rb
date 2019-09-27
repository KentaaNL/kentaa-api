# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Users < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          users = Kentaa::Api::Resources::Users.new(config, options)
          users.load
        end

        def get(id, options = {})
          user = Kentaa::Api::Resources::User.new(config, options.merge(id: id))
          user.load
        end
      end
    end
  end
end
