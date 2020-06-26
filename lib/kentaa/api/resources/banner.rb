# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Resources
      class Banner
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

        def url
          data[:url]
        end

        def text
          data[:text]
        end

        def link
          data[:link]
        end

        def locale
          data[:locale]
        end
      end
    end
  end
end
