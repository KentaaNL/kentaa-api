# frozen_string_literal: true

module Kentaa
  module Api
    module Requests
      class Donations < Base
        include Kentaa::Api::Requests::All

        def list(options = {})
          response = request.get("/donations", options)
          Kentaa::Api::Responses::Donations.build(response)
        end

        def get(id)
          response = request.get("/donations/#{id}")
          Kentaa::Api::Responses::Donation.build(response)
        end
      end
    end
  end
end
