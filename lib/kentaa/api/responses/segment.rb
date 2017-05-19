require 'bigdecimal'
require 'time'

module Kentaa
  module Api
    module Responses
      class Segment < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response[:segment] || response)
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
          BigDecimal.new(data[:total_amount])
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
                banners << Kentaa::Api::Responses::Banner.new(banner)
              end
            end

            banners
          end
        end
      end
    end
  end
end
