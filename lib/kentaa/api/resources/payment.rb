# frozen_string_literal: true

require 'bigdecimal'

module Kentaa
  module Api
    module Resources
      class Payment < Resource
        def object_key
          "Payment_#{id}"
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def site_id
          data[:site_id]
        end

        def currency
          data[:currency]
        end

        def amount
          BigDecimal(data[:amount])
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

        def transaction_id
          data[:transaction_id]
        end

        def payment_id
          data[:payment_id]
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

        def description
          data[:description]
        end

        def donations
          @donations ||= begin
            donations = []

            if data[:donations]
              data[:donations].each do |donation|
                donations << Kentaa::Api::Resources::Donation.new(config, data: donation, options: options)
              end
            end

            donations
          end
        end

        def orders
          @orders ||= begin
            orders = []

            if data[:orders]
              data[:orders].each do |order|
                orders << Kentaa::Api::Resources::Order.new(config, data: order, options: options)
              end
            end

            orders
          end
        end

        private

        def load_resource
          request.get("/payments/#{id}", options)
        end
      end
    end
  end
end
