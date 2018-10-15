# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Owner < Base
        include Kentaa::Api::Responses::Resource

        def initialize(response)
          super(response)
        end

        def first_name
          data[:first_name]
        end

        def infix
          data[:infix]
        end

        def last_name
          data[:last_name]
        end

        def name
          [first_name, infix, last_name].compact.join(" ")
        end

        def email
          data[:email]
        end

        def avatar_url
          data[:avatar_url]
        end
      end
    end
  end
end
