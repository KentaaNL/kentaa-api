# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class RegistrationFee
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def amount
          BigDecimal(data[:amount])
        end

        def title
          data[:title]
        end
      end
    end
  end
end
