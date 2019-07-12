# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Reward < Base
        include Kentaa::Api::Resources::Resource

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
