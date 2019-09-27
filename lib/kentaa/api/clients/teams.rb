# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Teams < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          teams = Kentaa::Api::Resources::Teams.new(config, options)
          teams.load
        end

        def get(id, options = {})
          team = Kentaa::Api::Resources::Team.new(config, options.merge(id: id))
          team.load
        end
      end
    end
  end
end
