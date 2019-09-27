# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Donation < Resource
        def object_key
          "Donation_#{id}"
        end

        def entity
          if action_id
            Kentaa::Api::Resources::Action.new(config, id: action_id)
          elsif team_id
            Kentaa::Api::Resources::Team.new(config, id: team_id)
          elsif project_id
            Kentaa::Api::Resources::Project.new(config, id: project_id)
          elsif segment_id
            Kentaa::Api::Resources::Segment.new(config, id: segment_id)
          else
            Kentaa::Api::Resources::Site.new(config, id: site_id)
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
                questions << Kentaa::Api::Resources::Question.new(config, data: question)
              end
            end

            questions
          end
        end

        def reward
          @reward ||= Kentaa::Api::Resources::Reward.new(config, data: data[:reward]) if data[:reward]
        end

        def address
          @address ||= Kentaa::Api::Resources::Address.new(config, data: data[:address]) if data[:address]
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
          @consent ||= Kentaa::Api::Resources::Consent.new(config, data: data[:consent]) if data[:consent]
        end

        protected

        def load_resource(options)
          request.get("/donations/#{id}", options)
        end
      end
    end
  end
end
