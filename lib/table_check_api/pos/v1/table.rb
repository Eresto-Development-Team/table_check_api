# frozen_string_literal: true

require_relative "base_request"
require_relative "base_response"

module TableCheckApi
  module Pos
    module V1
      # Service class for TableCheck Table endpoints.
      #
      # Usage:
      #   TableCheckApi::Pos::V1::Table.list(shop_id)
      #   request = TableCheckApi::Pos::V1::Table::StatusRequest.new(table_id: 'id', time: '2020-01-29T19:00:00Z')
      #   TableCheckApi::Pos::V1::Table.status(shop_id, request)
      #   TableCheckApi::Pos::V1::Table.status(shop_id, request, headers: { 'Authorization' => 'Bearer other_key' })
      class Table
        RESOURCE_PATH = '/pos/v1/shops'

        # GET /shops/:shop_id/tables — List all tables for a specific shop.
        def self.list(shop_id, headers: {})
          response = TableCheckApi::Client.get(
            "#{RESOURCE_PATH}/#{shop_id}/tables",
            headers: headers
          )

          ListResponse.from_response(response)
        end

        # POST /shops/:shop_id/table_status/show — Show the status of a table.
        def self.status(shop_id, request, headers: {})
          response = TableCheckApi::Client.post(
            "#{RESOURCE_PATH}/#{shop_id}/table_status/show",
            params: build_payload(request),
            headers: headers
          )

          StatusResponse.from_response(response)
        end

        def self.build_payload(request)
          raise ArgumentError, 'request must respond to :to_h' unless request.respond_to?(:to_h)
          request.to_h
        end

        class StatusRequest < BaseRequest
          ATTRIBUTES = %i[table_id time].freeze
          attr_accessor(*ATTRIBUTES)
        end

        class ListResponse < BaseResponse
          def tables
            body['tables'] || []
          end
        end

        class StatusResponse < BaseResponse
          def table_status
            body['table_status'] || {}
          end
        end
      end
    end
  end
end