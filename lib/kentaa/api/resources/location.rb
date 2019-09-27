# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Location < Resource
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
