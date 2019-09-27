# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Sites < Base
        def current(options = {})
          site = Kentaa::Api::Resources::Site.new(config, options)
          site.load
        end
      end
    end
  end
end
