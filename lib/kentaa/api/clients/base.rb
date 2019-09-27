# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Base
        attr_reader :config

        def initialize(config)
          @config = config
        end
      end
    end
  end
end
