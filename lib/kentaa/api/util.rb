# frozen_string_literal: true

module Kentaa
  module Api
    module Util
      module_function

      def pluralize(string)
        if string[-1] == 'y'
          "#{string.chop}ies"
        else
          "#{string}s"
        end
      end
    end
  end
end
