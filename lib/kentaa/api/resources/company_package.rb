# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class CompanyPackage
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def id
          data[:id]
        end

        def created_at
          Time.parse(data[:created_at]) if data[:created_at]
        end

        def updated_at
          Time.parse(data[:updated_at]) if data[:updated_at]
        end

        def amount
          data[:amount]
        end

        def title
          data[:title]
        end

        def description
          data[:description]
        end
      end
    end
  end
end
