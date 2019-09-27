# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Question < Resource
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
