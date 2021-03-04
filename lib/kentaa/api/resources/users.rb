# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Users < List
        include Enumerable

        def each(&block)
          users.each(&block)
        end

        def create(attributes = {})
          user = Kentaa::Api::Resources::User.new(config, options)
          user.save(attributes)
        end

        def auth(attributes = {})
          user = Kentaa::Api::Resources::User.new(config, options)
          user.auth(attributes)
        end

        private

        def load_resource
          request.get("/users", options)
        end

        def users
          @users ||= begin
            users = []

            if data
              data.each do |user|
                users << Kentaa::Api::Resources::User.new(config, data: user)
              end
            end

            users
          end
        end
      end
    end
  end
end
