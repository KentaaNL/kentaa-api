# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Question < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response)
        end

        def question
          data[:question]
        end

        def answer
          data[:answer]
        end
      end
    end
  end
end
