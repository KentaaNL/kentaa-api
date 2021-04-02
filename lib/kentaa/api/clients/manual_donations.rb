# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class ManualDonations < Base
        def all(options = {})
          donations = Kentaa::Api::Resources::ManualDonations.new(config, options)
          donations.all
        end

        def list(options = {})
          donations = Kentaa::Api::Resources::ManualDonations.new(config, options)
          donations.load
        end

        def get(id, options = {})
          donation = Kentaa::Api::Resources::ManualDonation.new(config, id: id, options: options)
          donation.load
        end

        def create(attributes = {}, options = {})
          donation = Kentaa::Api::Resources::ManualDonations.new(config, options)
          donation.create(attributes)
        end

        def update(id, attributes = {}, options = {})
          donation = Kentaa::Api::Resources::ManualDonation.new(config, id: id, options: options)
          donation.save(attributes)
        end

        def delete(id, options = {})
          donation = Kentaa::Api::Resources::ManualDonation.new(config, id: id, options: options)
          donation.delete
        end
      end
    end
  end
end
