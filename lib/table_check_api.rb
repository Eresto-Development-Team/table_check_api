# frozen_string_literal: true

require 'httparty'

require_relative "table_check_api/version"
require_relative "table_check_api/configuration"
require_relative "table_check_api/pos/v1/base_response"
require_relative "table_check_api/pos/v1/shop"
require_relative "table_check_api/pos/v1/table"
require_relative "table_check_api/pos/v1/pos_journals"

module TableCheckApi
  # Central HTTP client for all TableCheck API communication.
  # Service classes (Pos::V1::Shop, etc.) delegate to these methods.
  #
  # Headers can be overridden per-request to support per-call key overrides:
  #   Client.get('/path', headers: { 'Authorization' => 'Bearer other_key' })
  module Client
    def self.default_headers
      {
        'User-Agent' => "TableCheckAPIClient-v#{TableCheckApi::VERSION}",
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{TableCheckApi.key}"
      }.freeze
    end

    def self.get(path, params: {}, headers: {})
      HTTParty.get(
        "#{TableCheckApi.base_url}#{path}",
        query: params,
        headers: default_headers.dup.merge(headers)
      )
    end

    def self.post(path, params: {}, headers: {})
      HTTParty.post(
        "#{TableCheckApi.base_url}#{path}",
        body: params.to_json,
        headers: default_headers.dup.merge(headers)
      )
    end

    def self.put(path, params: {}, headers: {})
      HTTParty.put(
        "#{TableCheckApi.base_url}#{path}",
        body: params.to_json,
        headers: default_headers.dup.merge(headers)
      )
    end

    def self.delete(path, headers: {})
      HTTParty.delete(
        "#{TableCheckApi.base_url}#{path}",
        headers: default_headers.dup.merge(headers)
      )
    end
  end
end
