# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class Donations < Base
        def all(options = {})
          donations = Kentaa::Api::Resources::Donations.new(config, options)
          donations.all
        end

        def list(options = {})
          donations = Kentaa::Api::Resources::Donations.new(config, options)
          donations.load
        end

        def get(id, options = {})
          donation = Kentaa::Api::Resources::Donation.new(config, options.merge(id: id))
          donation.load
        end
      end
    end
  end
end
