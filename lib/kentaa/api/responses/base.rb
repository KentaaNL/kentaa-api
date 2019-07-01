# frozen_string_literal: true

require 'json'

module Kentaa
  module Api
    module Responses
      class Base
        attr_reader :data

        def initialize(response)
          if response.respond_to?(:body)
            extend Kentaa::Api::Responses::Status

            @response = response
            @data = response.body[attribute_key]
          else
            @data = response
          end

          @data ||= {}
        end

        private

        def attribute_key
          class_name = self.class.name.split("::").last
          class_name.gsub(/([^\^])([A-Z])/, '\1_\2').downcase.to_sym
        end
      end
    end
  end
end
