# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Question
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def id
          data[:id]
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
