# frozen_string_literal: true

require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Resources
      class Segment < Resource
        def object_key
          "Segment_#{id}"
        end

        def site_id
          data[:site_id]
        end

        def subdomain
          data[:subdomain]
        end

        def name
          data[:name]
        end

        def title
          data[:title]
        end

        def description
          data[:description]
        end

        def target_amount
          data[:target_amount]
        end

        def total_amount
          BigDecimal(data[:total_amount])
        end

        def total_donations
          data[:total_donations]
        end

        def end_date
          Time.parse(data[:end_date]) if data[:end_date]
        end

        def url
          data[:url]
        end

        def donate_url
          data[:donate_url]
        end

        def banners
          @banners ||= begin
            banners = []

            if data[:banners]
              data[:banners].each do |banner|
                banners << Kentaa::Api::Resources::Banner.new(banner)
              end
            end

            banners
          end
        end

        def external_reference
          data[:external_reference]
        end

        def donations
          @donations ||= Kentaa::Api::Resources::Donations.new(config, segment_id: id)
        end

        def manual_donations
          @manual_donations ||= Kentaa::Api::Resources::ManualDonations.new(config, segment_id: id)
        end

        private

        def load_resource
          request.get("/segments/#{id}", options)
        end
      end
    end
  end
end
