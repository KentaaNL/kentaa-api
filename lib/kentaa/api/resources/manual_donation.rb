# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class ManualDonation < Resource
        def object_key
          "Donation_#{id}"
        end

        def entity
          if action_id
            Kentaa::Api::Resources::Action.new(config, id: action_id, options: options)
          elsif team_id
            Kentaa::Api::Resources::Team.new(config, id: team_id, options: options)
          elsif company_id
            Kentaa::Api::Resources::Company.new(config, id: company_id, options: options)
          elsif project_id
            Kentaa::Api::Resources::Project.new(config, id: project_id, options: options)
          elsif segment_id
            Kentaa::Api::Resources::Segment.new(config, id: segment_id, options: options)
          elsif donation_form_id
            Kentaa::Api::Resources::DonationForm.new(config, id: donation_form_id, options: options)
          else
            Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
          end
        end

        def site
          Kentaa::Api::Resources::Site.new(config, id: site_id, options: options)
        end

        def public_id
          data[:public_id]
        end

        def site_id
          data[:site_id]
        end

        def donation_form_id
          data[:donation_form_id]
        end

        def segment_id
          data[:segment_id]
        end

        def company_id
          data[:company_id]
        end

        def project_id
          data[:project_id]
        end

        def team_id
          data[:team_id]
        end

        def action_id
          data[:action_id]
        end

        def first_name
          data[:first_name]
        end

        def infix
          data[:infix]
        end

        def last_name
          data[:last_name]
        end

        def name
          [first_name, infix, last_name].reject { |s| s.to_s.empty? }.join(' ')
        end

        def anonymous?
          data[:anonymous]
        end

        def email
          data[:email]
        end

        def message
          data[:message]
        end

        def currency
          data[:currency]
        end

        def amount
          BigDecimal(data[:amount])
        end

        def countable?
          data[:countable]
        end

        def target_url
          data[:target_url]
        end

        private

        def load_resource
          request.get("/manual-donations/#{id}", options)
        end

        def create_resource(attributes)
          request.post('/manual-donations', options, attributes)
        end

        def update_resource(attributes)
          request.patch("/manual-donations/#{id}", options, attributes)
        end

        def delete_resource
          request.delete("/manual-donations/#{id}", options)
        end
      end
    end
  end
end
