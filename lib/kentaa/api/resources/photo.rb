# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Photo < Base
        include Kentaa::Api::Resources::Resource

        def url
          data[:url]
        end
      end
    end
  end
end