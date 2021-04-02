# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class RecurringDonors < Base
        def all(options = {})
          recurring_donors = Kentaa::Api::Resources::RecurringDonors.new(config, options)
          recurring_donors.all
        end

        def list(options = {})
          recurring_donors = Kentaa::Api::Resources::RecurringDonors.new(config, options)
          recurring_donors.load
        end

        def get(id, options = {})
          recurring_donor = Kentaa::Api::Resources::RecurringDonor.new(config, id: id, options: options)
          recurring_donor.load
        end
      end
    end
  end
end
