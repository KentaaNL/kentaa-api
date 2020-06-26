# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Actions < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          actions = Kentaa::Api::Resources::Actions.new(config, options)
          actions.load
        end

        def get(id, options = {})
          action = Kentaa::Api::Resources::Action.new(config, options.merge(id: id))
          action.load
        end

        def create(attributes = {}, options = {})
          action = Kentaa::Api::Resources::Action.new(config, options)
          action.save(attributes)
        end

        def update(id, attributes = {}, options = {})
          action = Kentaa::Api::Resources::Action.new(config, options.merge(id: id))
          action.save(attributes)
        end
      end
    end
  end
end
