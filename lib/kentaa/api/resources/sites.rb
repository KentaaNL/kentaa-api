# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Sites < Base
        def current(options = {})
          site = Kentaa::Api::Resources::Site.new(config, options: options)
          site.load
        end
      end
    end
  end
end
