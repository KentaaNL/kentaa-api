# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Donations < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          response = request.get("/donations", options)
          Kentaa::Api::Resources::Donations.new(config, response)
        end

        def get(id, options = {})
          response = request.get("/donations/#{id}", options)
          Kentaa::Api::Resources::Donation.new(config, response)
        end
      end
    end
  end
end
