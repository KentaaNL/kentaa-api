# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Donations < List
        include Enumerable

        def each(&block)
          donations.each(&block)
        end

        private

        def load_resource
          request.get("/donations", options)
        end

        def donations
          @donations ||= begin
            donations = []

            if data
              data.each do |donation|
                donations << Kentaa::Api::Resources::Donation.new(config, data: donation)
              end
            end

            donations
          end
        end
      end
    end
  end
end
