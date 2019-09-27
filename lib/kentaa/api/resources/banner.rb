# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Banner < Resource
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
