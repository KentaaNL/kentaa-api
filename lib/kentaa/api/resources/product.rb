# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Product
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def id
          data[:id]
        end

        def title
          data[:title]
        end

        def variant_id
          data[:variant_id]
        end

        def variant_title
          data[:variant_title]
        end

        def price
          BigDecimal(data[:price])
        end

        def currency
          data[:currency]
        end
      end
    end
  end
end
