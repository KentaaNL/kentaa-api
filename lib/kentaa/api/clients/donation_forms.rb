# frozen_string_literal: true

module Kentaa
  module Api
    module Clients
      class DonationForms < Base
        def all(options = {})
          donation_forms = Kentaa::Api::Resources::DonationForms.new(config, options)
          donation_forms.all
        end

        def list(options = {})
          donation_forms = Kentaa::Api::Resources::DonationForms.new(config, options)
          donation_forms.load
        end

        def get(id, options = {})
          donation_form = Kentaa::Api::Resources::DonationForm.new(config, options.merge(id: id))
          donation_form.load
        end
      end
    end
  end
end
