# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class OrderItem
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def product
          Kentaa::Api::Resources::Product.new(data[:product])
        end

        def quantity
          data[:quantity]
        end

        def amount
          BigDecimal(data[:amount])
        end

        def currency
          data[:currency]
        end
      end
    end
  end
end
