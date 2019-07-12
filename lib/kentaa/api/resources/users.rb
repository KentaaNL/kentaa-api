# frozen_string_literal: true

module Kentaa
  module Api
    module Resources
      class Users < Base
        include Enumerable
        include Kentaa::Api::Resources::Pagination

        def each(&block)
          users.each(&block)
        end

        private

        def users
          @users ||= begin
            users = []

            if data
              data.each do |user|
                users << Kentaa::Api::Resources::User.new(config, user)
              end
            end

            users
          end
        end
      end
    end
  end
end
