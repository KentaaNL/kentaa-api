# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class ManualDonations < List
        include Enumerable

        def each(&block)
          manual_donations.each(&block)
        end

        def create(attributes = {})
          donation = Kentaa::Api::Resources::ManualDonation.new(config, options)
          donation.save(attributes)
        end

        private

        def load_resource
          request.get("/manual-donations", options)
        end

        def manual_donations
          @manual_donations ||= begin
            manual_donations = []

            if data
              data.each do |manual_donation|
                manual_donations << Kentaa::Api::Resources::ManualDonation.new(config, data: manual_donation)
              end
            end

            manual_donations
          end
        end
      end
    end
  end
end
