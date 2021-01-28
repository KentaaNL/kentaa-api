# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class DonationForms < List
        include Enumerable

        def each(&block)
          donation_forms.each(&block)
        end

        private

        def load_resource
          request.get("/donation-forms", options)
        end

        def donation_forms
          @donation_forms ||= begin
            donation_forms = []

            if data
              data.each do |donation_form|
                donation_forms << Kentaa::Api::Resources::DonationForm.new(config, data: donation_form)
              end
            end

            donation_forms
          end
        end
      end
    end
  end
end
