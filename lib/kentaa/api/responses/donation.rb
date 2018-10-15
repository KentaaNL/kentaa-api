require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Responses
      class Donation < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response[:donation] || response)
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

        def target_url
          data[:target_url]
        end

        def questions
          @questions ||= begin
            questions = []

            if data[:questions]
              data[:questions].each do |question|
                questions << Kentaa::Api::Responses::Question.new(question)
              end
            end

            questions
          end
        end

        def reward
          @reward ||= Kentaa::Api::Responses::Reward.new(data[:reward]) if data[:reward]
        end

        def address
          @address ||= Kentaa::Api::Responses::Address.new(data[:address]) if data[:address]
        end
      end
    end
  end
end
