# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Logo
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def url
          data[:url]
        end

        def locale
          data[:locale]
        end
      end
    end
  end
end
