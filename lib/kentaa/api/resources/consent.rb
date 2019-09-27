# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Consent < Resource
        def url
          data[:url]
        end

        def text
          data[:text]
        end

        def version
          data[:version]
        end
      end
    end
  end
end
