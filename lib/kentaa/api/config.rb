# frozen_string_literal: true

module Kentaa
  module Api
    class Config
      LIVE_URL = "https://api.kentaa.nl"
      TEST_URL = "https://api.kentaa.staatklaar.nu"
      DEV_URL  = "http://api.lvh.me:3000"

      API_VERSION = "v1"

      attr_accessor :api_key, :options

      def initialize(api_key, options = {})
        @api_key = api_key
        @options = options
      end

      def api_url
        url =
          if options[:test]
            TEST_URL
          elsif options[:dev]
            DEV_URL
          else
            LIVE_URL
          end

        File.join(url, API_VERSION)
      end
    end
  end
end
