# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Billing
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def attn
          data[:attn]
        end

        def street
          data[:street]
        end

        def house_number
          data[:house_number]
        end

        def house_number_addition
          data[:house_number_addition]
        end

        def address
          data[:address]
        end

        def address2
          data[:address2]
        end

        def zipcode
          data[:zipcode]
        end

        def city
          data[:city]
        end

        def country
          data[:country]
        end
      end
    end
  end
end
