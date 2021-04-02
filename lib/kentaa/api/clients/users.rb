# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Users < Base
        def all(options = {})
          users = Kentaa::Api::Resources::Users.new(config, options)
          users.all
        end

        def list(options = {})
          users = Kentaa::Api::Resources::Users.new(config, options)
          users.load
        end

        def get(id, options = {})
          user = Kentaa::Api::Resources::User.new(config, id: id, options: options)
          user.load
        end

        def create(attributes = {}, options = {})
          user = Kentaa::Api::Resources::Users.new(config, options)
          user.create(attributes)
        end

        def update(id, attributes = {}, options = {})
          user = Kentaa::Api::Resources::User.new(config, id: id, options: options)
          user.save(attributes)
        end

        def auth(attributes = {}, options = {})
          user = Kentaa::Api::Resources::Users.new(config, options)
          user.auth(attributes)
        end
      end
    end
  end
end
