# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Order < Resource
        def entity
          if action_id
            Kentaa::Api::Resources::Action.new(config, id: action_id, options: options)
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
          [first_name, infix, last_name].reject { |s| s.to_s.empty? }.join(' ')
        end

        def company
          data[:company]
        end

        def currency
          data[:currency]
        end

        def total_amount
          BigDecimal(data[:total_amount])
        end

        def invoicenumber
          data[:invoicenumber]
        end

        def payment_status
          data[:payment_status]
        end

        def address
          @address ||= Kentaa::Api::Resources::Address.new(data[:address]) if data[:address]
        end

        def phone
          data[:phone]
        end

        def items
          @items ||= begin
            items = []

            if data[:items]
              data[:items].each do |item|
                items << Kentaa::Api::Resources::OrderItem.new(item)
              end
            end

            items
          end
        end

        private

        def load_resource
          request.get("/orders/#{id}", options)
        end
      end
    end
  end
end
