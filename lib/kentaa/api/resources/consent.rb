# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Resources
      class Consent
        STATUS_GRANTED = 'granted'
        STATUS_REVOKED = 'revoked'

        attr_reader :data

        def initialize(data)
          @data = data
        end

        def consent_type
          data[:consent_type]
        end

        def consent_status
          data[:consent_status]
        end

        def granted?
          consent_status == STATUS_GRANTED
        end

        def revoked?
          consent_status == STATUS_REVOKED
        end

        def granted_at
          Time.parse(data[:granted_at])
        end

        def revoked_at
          Time.parse(data[:revoked_at]) if data[:revoked_at]
        end

        def consent_text
          data[:consent_text]
        end

        def text
          data[:text] || data[:consent_text]
        end

        def url
          data[:url]
        end

        def version
          data[:version] || data[:terms_conditions_version]
        end

        def terms_conditions_version
          data[:terms_conditions_version]
        end
      end
    end
  end
end
