# frozen_string_literal: true

module Kentaa
  module Api
    class Config
      LIVE_URL = 'https://api.kentaa.nl/v1'
      TEST_URL = 'https://api.kentaa.staatklaar.nu/v1'
      DEV_URL  = 'http://api.lvh.me:3000/v1'

      attr_accessor :options

      def initialize(options = {})
        @options = options
      end

      def api_key
        options.fetch(:api_key)
      end

      def api_url
        if options[:api_url]
          options[:api_url]
        elsif options[:test]
          TEST_URL
        elsif options[:dev]
          DEV_URL
        else
          LIVE_URL
        end
      end

      def debug?
        options.fetch(:debug, false)
      end
    end
  end
end
