# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Photo < Resource
        def url
          data[:url]
        end
      end
    end
  end
end
