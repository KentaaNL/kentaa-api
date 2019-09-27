# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Users < List
        include Enumerable

        def each(&block)
          users.each(&block)
        end

        protected

        def load_resource(options)
          request.get("/users", options)
        end

        private

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
