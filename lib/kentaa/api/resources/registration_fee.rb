# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class RegistrationFee < Base
        def amount
          data[:amount]
        end

        def title
          data[:title]
        end
      end
    end
  end
end