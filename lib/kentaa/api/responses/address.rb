# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Address < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response)
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
