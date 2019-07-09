# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module Kentaa
  module Api
    class Request
      attr_reader :config

      def initialize(config)
        @config = config
      end

      def get(path, params = {})
        uri = URI.parse(File.join(config.api_url, path))
        uri.query = URI.encode_www_form(params) unless params.empty?

        request = Net::HTTP::Get.new(uri)
        request["X-Api-Key"] = config.api_key

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
          http.request(request)
        end

        Kentaa::Api::Response.new(response)
      end
    end
  end
end
