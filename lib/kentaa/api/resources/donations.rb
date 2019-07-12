# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Donations < Base
        include Enumerable
        include Kentaa::Api::Resources::Pagination

        def each(&block)
          donations.each(&block)
        end

        private

        def donations
          @donations ||= begin
            donations = []

            if data
              data.each do |donation|
                donations << Kentaa::Api::Resources::Donation.new(config, donation)
              end
            end

            donations
          end
        end
      end
    end
  end
end
