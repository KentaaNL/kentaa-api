# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class RecurringDonor < Resource
        def object_key
          "RecurringDonor_#{id}"
        end

        def entity
          if donation_form_id
            Kentaa::Api::Resources::DonationForm.new(config, id: donation_form_id, options: options)
          else
            Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
          end
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def site_id
          data[:site_id]
        end

        def donation_form_id
          data[:donation_form_id]
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

        def company
          data[:company]
        end

        def anonymous?
          data[:anonymous]
        end

        def email
          data[:email]
        end

        def locale
          data[:locale]
        end

        def frequency_type
          data[:frequency_type]
        end

        def start_date
          Date.parse(data[:start_date])
        end

        def end_date
          Date.parse(data[:end_date]) if data[:end_date]
        end

        def active?
          data[:active]
        end

        def currency
          data[:currency]
        end

        def amount
          BigDecimal(data[:amount])
        end

        def transaction_costs
          BigDecimal(data[:transaction_costs]) if data[:transaction_costs]
        end

        def total_amount
          BigDecimal(data[:total_amount])
        end

        def donations
          @donations ||= Kentaa::Api::Resources::List.new(config, resource_class: Kentaa::Api::Resources::Donation, endpoint_path: "/recurring-donors/#{id}/donations")
        end

        private

        def load_resource
          request.get("/recurring-donors/#{id}", options)
        end
      end
    end
  end
end
