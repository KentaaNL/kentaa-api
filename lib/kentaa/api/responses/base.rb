# frozen_string_literal: true

require 'json'

module Kentaa
  module Api
    module Responses
      class Base
        attr_reader :data

        def initialize(data)
          @data = data || {}
        end

        class << self
          def build(response)
            data = response.body[attribute_key]

            object = new(data)
            object.extend(Kentaa::Api::Responses::Status)
            object.response = response
            object
          end

          private

          def attribute_key
            class_name = name.split("::").last
            class_name.gsub(/([^\^])([A-Z])/, '\1_\2').downcase.to_sym
          end
        end
      end
    end
  end
end
