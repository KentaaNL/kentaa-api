# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module Kentaa
  module Api
    class Request
      LIVE_URL = "https://api.kentaa.nl/v1/"
      TEST_URL = "https://api.kentaa.staatklaar.nu/v1/"
      DEV_URL  = "http://api.lvh.me:3000/v1"

      def initialize(api_key, options = {})
        @api_key = api_key
        @options = options
      end

      def get(path, params = {})
        uri = URI.parse(File.join(api_url, path))
        uri.query = URI.encode_www_form(params) unless params.empty?

        request = Net::HTTP::Get.new(uri)
        request["X-Api-Key"] = @api_key

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(request)
        end

        Kentaa::Api::Response.new(response)
      end

      private

      def api_url
        if @options[:test]
          TEST_URL
        elsif @options[:dev]
          DEV_URL
        else
          LIVE_URL
        end
      end
    end
  end
end
