# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Resources
      class SecurityActivity
        attr_reader :data

        def initialize(data)
          @data = data
        end

        def last_login_at
          Time.parse(data[:last_login_at]) if data[:last_login_at]
        end

        def reset_password_email_sent_at
          Time.parse(data[:reset_password_email_sent_at]) if data[:reset_password_email_sent_at]
        end

        def last_password_reset_at
          Time.parse(data[:last_password_reset_at]) if data[:last_password_reset_at]
        end
      end
    end
  end
end
