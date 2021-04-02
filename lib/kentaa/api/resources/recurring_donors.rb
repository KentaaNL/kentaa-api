# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class RecurringDonors < List
        include Enumerable

        def each(&block)
          recurring_donors.each(&block)
        end

        private

        def load_resource
          request.get("/recurring-donors", options)
        end

        def recurring_donors
          @recurring_donors ||= begin
            recurring_donors = []

            if data
              data.each do |recurring_donor|
                recurring_donors << Kentaa::Api::Resources::RecurringDonor.new(config, data: recurring_donor, options: options)
              end
            end

            recurring_donors
          end
        end
      end
    end
  end
end
