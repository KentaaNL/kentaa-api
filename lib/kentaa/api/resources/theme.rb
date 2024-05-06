# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Theme
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def primary_color
          data[:primary_color]
        end

        def contrast_color
          data[:contrast_color]
        end
      end
    end
  end
end
