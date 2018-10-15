# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Reward < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response)
        end

        def type
          data[:type]
        end

        def title
          data[:title]
        end

        def description
          data[:description]
        end

        def ask_for_address?
          data[:ask_for_address]
        end
      end
    end
  end
end
