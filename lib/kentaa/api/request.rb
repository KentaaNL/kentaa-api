# frozen_string_literal: true

require 'logger'
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
        request(:get, path, params)
      end

      def post(path, params = {}, body = {})
        request(:post, path, params, body)
      end

      def patch(path, params = {}, body = {})
        request(:patch, path, params, body)
      end

      def delete(path, params = {})
        request(:delete, path, params)
      end

      private

      def request(http_method, path, params = {}, body = {})
        uri = URI.parse(File.join(config.api_url, path))
        uri.query = URI.encode_www_form(params) unless params.empty?

        logger.debug("[Kentaa-API] Request: #{http_method.upcase} #{uri}") if config.debug?

        case http_method
        when :get
          request = Net::HTTP::Get.new(uri)
        when :post
          request = Net::HTTP::Post.new(uri)
          request.body = body.to_json
        when :patch
          request = Net::HTTP::Patch.new(uri)
          request.body = body.to_json
        when :delete
          request = Net::HTTP::Delete.new(uri)
        else
          raise Kentaa::Api::Exception, "Invalid HTTP method: #{http_method}"
        end

        request["Accept"] = "application/json"
        request["Content-Type"] = "application/json"
        request["X-Api-Key"] = config.api_key
        request["User-Agent"] = "Ruby kentaa-api/#{Kentaa::Api::VERSION}"

        client = Net::HTTP.new(uri.hostname, uri.port)
        client.use_ssl = uri.scheme == "https"
        client.verify_mode = OpenSSL::SSL::VERIFY_PEER

        begin
          response = Kentaa::Api::Response.new(client.request(request))
        # Try to catch some common exceptions Net::HTTP might raise.
        rescue Errno::ETIMEDOUT, Errno::EINVAL, Errno::ECONNRESET, Errno::ECONNREFUSED, Errno::EHOSTUNREACH,
               IOError, SocketError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::OpenTimeout,
               Net::ProtocolError, Net::ReadTimeout, OpenSSL::SSL::SSLError => e
          raise Kentaa::Api::Exception, e.message
        end

        logger.debug("[Kentaa-API] Response: #{response.http_code}, body: #{response.body}") if config.debug?

        if response.error?
          raise Kentaa::Api::RequestError, response
        end

        response
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end
    end
  end
end
