# frozen_string_literal: true

module Kentaa
  module Api
    module Responses
      class Users < Base
        include Enumerable
        include Kentaa::Api::Responses::Pagination

        def each(&block)
          users.each(&block)
        end

        private

        def users
          @users ||= begin
            users = []

            if data
              data.each do |user|
                segments << Kentaa::Api::Responses::User.new(user)
              end
            end

            users
          end
        end
      end
    end
  end
end
