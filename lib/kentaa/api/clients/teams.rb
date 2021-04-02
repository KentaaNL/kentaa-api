# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Teams < Base
        def all(options = {})
          teams = Kentaa::Api::Resources::Teams.new(config, options)
          teams.all
        end

        def list(options = {})
          teams = Kentaa::Api::Resources::Teams.new(config, options)
          teams.load
        end

        def get(id, options = {})
          team = Kentaa::Api::Resources::Team.new(config, id: id, options: options)
          team.load
        end
      end
    end
  end
end
