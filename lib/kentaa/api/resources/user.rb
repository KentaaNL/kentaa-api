# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Resources
      class User < Resource
        def object_key
          "User_#{id}"
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def site_id
          data[:site_id]
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
          [first_name, infix, last_name].reject { |s| s.to_s.empty? }.join(" ")
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

        def consent
          Kentaa::Api::Deprecation.warn("#consent is deprecated. Please use #consents instead.", caller)

          @consent ||= Kentaa::Api::Resources::Consent.new(data[:consent]) if data[:consent]
        end

        def consents
          @consents ||= begin
            consents = []

            if data[:consents]
              data[:consents].each do |consent|
                consents << Kentaa::Api::Resources::Consent.new(consent)
              end
            end

            consents
          end
        end

        def actions
          @actions ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Action, endpoint_path: "/users/#{id}/actions")
        end

        private

        def load_resource
          request.get("/users/#{id}", options)
        end

        def create_resource(attributes)
          request.post("/users", options, attributes)
        end

        def update_resource(attributes)
          request.patch("/users/#{id}", options, attributes)
        end
      end
    end
  end
end
