# frozen_string_literal: true

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

        begin
          result = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
            http.request(request)
          end
        # Try to catch some common exceptions Net::HTTP might raise.
        rescue Errno::ETIMEDOUT, Errno::EINVAL, Errno::ECONNRESET, Errno::ECONNREFUSED, Errno::EHOSTUNREACH,
               IOError, SocketError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::OpenTimeout,
               Net::ProtocolError, Net::ReadTimeout, OpenSSL::SSL::SSLError => e
          raise Kentaa::Api::Exception, e.message
        end

        response = Kentaa::Api::Response.new(result)

        if response.error?
          raise Kentaa::Api::RequestError, response
        end

        response
      end
    end
  end
end
