# frozen_string_literal: true

require 'bigdecimal'

module Kentaa
  module Api
    module Resources
      class Reward
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def id
          data[:id]
        end

        def type
          data[:type]
        end

        def amount
          BigDecimal(data[:amount])
        end

        def title
          data[:title]
        end

        def description
          data[:description]
        end

        def ask_for_address?
          data[:ask_for_address]
        end
      end
    end
  end
end
