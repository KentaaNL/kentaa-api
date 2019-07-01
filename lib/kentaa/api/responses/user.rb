# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Responses
      class User < Base
        include Kentaa::Api::Responses::Resource

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
          [first_name, infix, last_name].compact.join(" ")
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
          Time.parse(data[:birthday]) if data[:birthday]
        end

        def gender
          data[:gender]
        end

        def locale
          data[:locale]
        end

        def consent
          @consent ||= Kentaa::Api::Responses::Consent.new(data[:consent]) if data[:consent]
        end
      end
    end
  end
end
