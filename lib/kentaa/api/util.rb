# frozen_string_literal: true

module Kentaa
  module Api
    module Util
      module_function

      require 'dry/inflector'

      def pluralize(string)
        inflector = Dry::Inflector.new
        inflector.pluralize(string)
      end
    end
  end
end
