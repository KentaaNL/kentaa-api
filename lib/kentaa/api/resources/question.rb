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

        def created_at
          Time.parse(data[:created_at]) if data[:created_at]
        end

        def updated_at
          Time.parse(data[:updated_at]) if data[:updated_at]
        end

        def question
          data[:question]
        end

        def answer
          data[:answer]
        end

        def external_reference
          data[:external_reference]
        end
      end
    end
  end
end
