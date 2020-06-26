# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Error
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def field
          data[:field]
        end

        def error
          data[:error]
        end
      end
    end
  end
end
