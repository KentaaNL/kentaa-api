# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class ManualDonations < Base
        include Kentaa::Api::Clients::All

        def list(options = {})
          donations = Kentaa::Api::Resources::ManualDonations.new(config, options)
          donations.load
        end

        def get(id, options = {})
          donation = Kentaa::Api::Resources::ManualDonation.new(config, options.merge(id: id))
          donation.load
        end

        def create(attributes = {}, options = {})
          action = Kentaa::Api::Resources::ManualDonation.new(config, options)
          action.save(attributes)
        end

        def update(id, attributes = {}, options = {})
          action = Kentaa::Api::Resources::ManualDonation.new(config, options.merge(id: id))
          action.save(attributes)
        end

        def delete(id, options = {})
          action = Kentaa::Api::Resources::ManualDonation.new(config, options.merge(id: id))
          action.delete
        end
      end
    end
  end
end
