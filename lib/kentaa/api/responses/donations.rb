module Kentaa
  module Api
    module Responses
      class Donations < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def initialize(response)
          super(response)
        end

        def each(&block)
          donations.each(&block)
        end

        private

        def donations
          @donations ||= begin
            donations = []

            if data[:donations]
              data[:donations].each do |donation|
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
