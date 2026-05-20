# frozen_string_literal: true

module TableCheckApi
  module Pos
    module V1
      # Service class for TableCheck POS Journals endpoints.
      #
      # Usage:
      #   TableCheckApi::Pos::V1::PosJournals.create(shop_id, payload)
      #   TableCheckApi::Pos::V1::PosJournals.update(shop_id, id, payload)
      #   TableCheckApi::Pos::V1::PosJournals.void(shop_id, payload)
      #   TableCheckApi::Pos::V1::PosJournals.delete(shop_id, id)
      #   TableCheckApi::Pos::V1::PosJournals.delete(shop_id, id, headers: { 'Authorization' => 'Bearer x' })
      class PosJournals
        RESOURCE_PATH = '/pos/v1/shops'

        # POST /shops/:shop_id/pos_journals — Create a new POS journal entry.
        def self.create(shop_id, payload, headers: {})
          TableCheckApi::Client.post(
            "#{RESOURCE_PATH}/#{shop_id}/pos_journals",
            params: payload,
            headers: headers
          )
        end

        # PUT /shops/:shop_id/pos_journals/:id — Update an existing POS journal.
        # NOTE: Uses POST until Client.put is implemented.
        def self.update(shop_id, id, payload, headers: {})
          TableCheckApi::Client.post(
            "#{RESOURCE_PATH}/#{shop_id}/pos_journals/#{id}",
            params: payload,
            headers: headers
          )
        end

        # DELETE /shops/:shop_id/pos_journals/:id — Delete a POS journal.
        # NOTE: Uses POST until Client.delete is implemented.
        def self.delete(shop_id, id, headers: {})
          TableCheckApi::Client.post(
            "#{RESOURCE_PATH}/#{shop_id}/pos_journals/#{id}",
            params: { _method: 'delete' },
            headers: headers
          )
        end

        # POST /shops/:shop_id/pos_journals/void — Void a POS journal.
        def self.void(shop_id, payload, headers: {})
          TableCheckApi::Client.post(
            "#{RESOURCE_PATH}/#{shop_id}/pos_journals/void",
            params: payload,
            headers: headers
          )
        end
      end
    end
  end
end