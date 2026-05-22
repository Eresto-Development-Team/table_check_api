# frozen_string_literal: true

require_relative "base_response"

module TableCheckApi
  module Pos
    module V1
      # Service class for TableCheck Shop endpoints.
      #
      # Usage:
      #   TableCheckApi::Pos::V1::Shop.list
      #   TableCheckApi::Pos::V1::Shop.list(headers: { 'Authorization' => 'Bearer other_key' })
      class Shop
        RESOURCE_PATH = '/pos/v1/shops'

        # GET /shops — List accessible restaurant/venue operations.
        def self.list(headers: {})
          response = TableCheckApi::Client.get(RESOURCE_PATH, headers: headers)
          ListResponse.from_response(response)
        end

        class ListResponse < BaseResponse
          def shops
            body['shops'] || []
          end
        end
      end
    end
  end
end