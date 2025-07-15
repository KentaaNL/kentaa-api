# frozen_string_literal: true

require 'dry/inflector'

module Kentaa
  module Api
    module Util
      module_function

      def pluralize(string)
        inflector = Dry::Inflector.new
        inflector.pluralize(string)
      end
    end
  end
end
