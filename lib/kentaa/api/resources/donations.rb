# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Donations < List
        include Enumerable

        def each(&block)
          donations.each(&block)
        end

        protected

        def load_resource(options)
          request.get("/donations", options)
        end

        private

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
