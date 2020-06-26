# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Location
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def zip_code
          data[:zip_code]
        end

        def street
          data[:street]
        end

        def city
          data[:city]
        end

        def latitude
          data[:latitude]
        end

        def longitude
          data[:longitude]
        end
      end
    end
  end
end
