# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Donation < Base
        include Kentaa::Api::Resources::Resource

        def object_key
          "Donation_#{id}"
        end

        def entity
          if action_id
            client = Kentaa::Api::Clients::Actions.new(config)
            client.get(action_id)
          elsif team_id
            client = Kentaa::Api::Clients::Teams.new(config)
            client.get(team_id)
          elsif project_id
            client = Kentaa::Api::Clients::Projects.new(config)
            client.get(project_id)
          elsif segment_id
            client = Kentaa::Api::Clients::Segments.new(config)
            client.get(segment_id)
          else
            client = Kentaa::Api::Clients::Sites.new(config)
            client.current
          end
        end

        def site_id
          data[:site_id]
        end

        def segment_id
          data[:segment_id]
        end

        def project_id
          data[:project_id]
        end

        def team_id
          data[:team_id]
        end

        def action_id
          data[:action_id]
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
          [first_name, infix, last_name].compact.join(" ")
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

        def message
          data[:message]
        end

        def newsletter?
          data[:newsletter]
        end

        def device_type
          data[:device_type]
        end

        def locale
          data[:locale]
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

        def registration_fee?
          data[:registration_fee]
        end

        def registration_fee_amount
          BigDecimal(data[:registration_fee_amount]) if data[:registration_fee_amount]
        end

        def total_amount
          BigDecimal(data[:total_amount])
        end

        def countable?
          data[:countable]
        end

        def invoicenumber
          data[:invoicenumber]
        end

        def payment_method
          data[:payment_method]
        end

        def payment_status
          data[:payment_status]
        end

        def payment_status_at
          Time.parse(data[:payment_status_at]) if data[:payment_status_at]
        end

        def transaction_id
          data[:transaction_id]
        end

        def payment_id
          data[:payment_id]
        end

        def payment_description
          data[:payment_description]
        end

        def account_iban
          data[:account_iban]
        end

        def account_bic
          data[:account_bic]
        end

        def account_name
          data[:account_name]
        end

        def target_url
          data[:target_url]
        end

        def questions
          @questions ||= begin
            questions = []

            if data[:questions]
              data[:questions].each do |question|
                questions << Kentaa::Api::Resources::Question.new(config, question)
              end
            end

            questions
          end
        end

        def reward
          @reward ||= Kentaa::Api::Resources::Reward.new(config, data[:reward]) if data[:reward]
        end

        def address
          @address ||= Kentaa::Api::Resources::Address.new(config, data[:address]) if data[:address]
        end

        def birthday
          Time.parse(data[:birthday]) if data[:birthday]
        end

        def gender
          data[:gender]
        end

        def phone
          data[:phone]
        end

        def consent
          @consent ||= Kentaa::Api::Resources::Consent.new(config, data[:consent]) if data[:consent]
        end
      end
    end
  end
end
