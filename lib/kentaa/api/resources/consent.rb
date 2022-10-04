# frozen_string_literal: true

require 'time'

module Kentaa
  module Api
    module Resources
      class Consent
        STATUS_GRANTED = 'granted'
        STATUS_REVOKED = 'revoked'

        TYPE_TERMS_CONDITIONS = 'terms_conditions'
        TYPE_PROCESSING_PERSONAL_DATA = 'processing_personal_data'
        TYPE_PROCESSING_PERSONAL_SENSITIVE_DATA = 'processing_personal_sensitive_data'
        TYPE_NEWSLETTER_SUBSCRIPTION = 'newsletter_subscription'
        TYPE_NEWS_ITEM_SUBSCRIPTION = 'news_item_subscription'
        TYPE_CONTACT_PHONE = 'contact_phone'
        TYPE_CONTACT_PHONE_COMMERCIAL = 'contact_phone_commercial'

        attr_reader :data

        def initialize(data)
          @data = data
        end

        def consent_type
          data[:consent_type]
        end

        def terms_conditions?
          consent_type == TYPE_TERMS_CONDITIONS
        end

        def processing_personal_data?
          consent_type == TYPE_PROCESSING_PERSONAL_DATA
        end

        def processing_personal_sensitive_data?
          consent_type == TYPE_PROCESSING_PERSONAL_SENSITIVE_DATA
        end

        def newsletter_subscription?
          consent_type == TYPE_NEWSLETTER_SUBSCRIPTION
        end

        def news_item_subscription?
          consent_type == TYPE_NEWS_ITEM_SUBSCRIPTION
        end

        def contact_phone?
          consent_type == TYPE_CONTACT_PHONE
        end

        def contact_phone_commercial?
          consent_type == TYPE_CONTACT_PHONE_COMMERCIAL
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

        def privacy_version
          data[:privacy_version]
        end
      end
    end
  end
end
