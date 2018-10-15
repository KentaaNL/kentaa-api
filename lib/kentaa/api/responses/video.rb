# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Video < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response)
        end

        def url
          data[:url]
        end
      end
    end
  end
end
