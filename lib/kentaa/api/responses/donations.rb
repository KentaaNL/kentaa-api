# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Donations < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def each(&block)
          donations.each(&block)
        end

        private

        def donations
          @donations ||= begin
            donations = []

            if data
              data.each do |donation|
                donations << Kentaa::Api::Responses::Donation.new(donation)
              end
            end

            donations
          end
        end
      end
    end
  end
end
