# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Contact
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def first_name
          data[:first_name]
        end

        def infix
          data[:infix]
        end

        def last_name
          data[:last_name]
        end

        def name
          [first_name, infix, last_name].reject { |s| s.to_s.empty? }.join(' ')
        end

        def email
          data[:email]
        end

        def avatar_url
          data[:avatar_url]
        end

        def address
          data[:address]
        end

        def address2
          data[:address2]
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

        def zipcode
          data[:zipcode]
        end

        def city
          data[:city]
        end

        def country
          data[:country]
        end

        def phone
          data[:phone]
        end

        def birthday
          Date.parse(data[:birthday]) if data[:birthday]
        end

        def gender
          data[:gender]
        end

        def locale
          data[:locale]
        end
      end
    end
  end
end
