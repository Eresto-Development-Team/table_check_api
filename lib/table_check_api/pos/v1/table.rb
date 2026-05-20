# frozen_string_literal: true

module TableCheckApi
  module Pos
    module V1
      # Service class for TableCheck Table endpoints.
      #
      # Usage:
      #   TableCheckApi::Pos::V1::Table.list(shop_id)
      #   TableCheckApi::Pos::V1::Table.status(shop_id)
      #   TableCheckApi::Pos::V1::Table.status(shop_id, headers: { 'Authorization' => 'Bearer other_key' })
      class Table
        RESOURCE_PATH = '/pos/v1/shops'

        # GET /shops/:shop_id/tables — List all tables for a specific shop.
        def self.list(shop_id, headers: {})
          TableCheckApi::Client.get(
            "#{RESOURCE_PATH}/#{shop_id}/tables",
            headers: headers
          )
        end

        # GET /shops/:shop_id/table_status/show — Show the status of a table.
        def self.status(shop_id, headers: {})
          TableCheckApi::Client.get(
            "#{RESOURCE_PATH}/#{shop_id}/table_status/show",
            headers: headers
          )
        end
      end
    end
  end
end