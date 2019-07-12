# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Question < Base
        include Kentaa::Api::Resources::Resource

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
