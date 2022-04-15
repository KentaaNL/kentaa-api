# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Users < List
        def initialize(config, options = {})
          super(config, options.merge(resource_class: Kentaa::Api::Resources::User, endpoint_path: '/users'))
        end

        def auth(attributes, options = {})
          resource = resource_class.new(config, options: options)
          resource.load { request.post("#{endpoint_path}/auth", options, attributes) }
        end
      end
    end
  end
end
