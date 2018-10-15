# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Donations < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = http.get("/donations", options)
          Kentaa::Api::Responses::Donations.new(response)
        end

        def get(id)
          response = http.get("/donations/#{id}")
          Kentaa::Api::Responses::Donation.new(response)
        end
      end
    end
  end
end
