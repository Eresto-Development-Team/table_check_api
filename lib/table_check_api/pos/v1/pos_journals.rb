# frozen_string_literal: true

require_relative "base_request"
require_relative "base_response"

module TableCheckApi
  module Pos
    module V1
      # Service class for TableCheck POS Journals endpoints.
      #
      # Usage:
      #   request = TableCheckApi::Pos::V1::PosJournals::CreateRequest.new(batch_date: '2020-01-01')
      #   TableCheckApi::Pos::V1::PosJournals.create(shop_id, request)
      #
      #   update_request = TableCheckApi::Pos::V1::PosJournals::UpdateRequest.new(...)
      #   TableCheckApi::Pos::V1::PosJournals.update(shop_id, id, update_request)
      #
      #   void_request = TableCheckApi::Pos::V1::PosJournals::VoidRequest.new(receipt_num: '12345', void_reason: 'customer_cancellation')
      #   TableCheckApi::Pos::V1::PosJournals.void(shop_id, void_request)
      class PosJournals
        RESOURCE_PATH = '/pos/v1/shops'

        # POST /shops/:shop_id/pos_journals — Create a new POS journal entry.
        def self.create(shop_id, request, headers: {})
          response = TableCheckApi::Client.post(
            "#{RESOURCE_PATH}/#{shop_id}/pos_journals",
            params: build_payload(request),
            headers: headers
          )

          CreateResponse.from_response(response)
        end

        # PUT /shops/:shop_id/pos_journals/:id — Update an existing POS journal.
        def self.update(shop_id, id, request, headers: {})
          response = TableCheckApi::Client.put(
            "#{RESOURCE_PATH}/#{shop_id}/pos_journals/#{id}",
            params: build_payload(request),
            headers: headers
          )

          PosJournalResponse.from_response(response)
        end

        # DELETE /shops/:shop_id/pos_journals/:id — Delete a POS journal.
        def self.delete(shop_id, id, headers: {})
          response = TableCheckApi::Client.delete(
            "#{RESOURCE_PATH}/#{shop_id}/pos_journals/#{id}",
            headers: headers
          )

          DeleteResponse.from_response(response)
        end

        # POST /shops/:shop_id/pos_journals/void — Void a POS journal.
        def self.void(shop_id, request, headers: {})
          response = TableCheckApi::Client.post(
            "#{RESOURCE_PATH}/#{shop_id}/pos_journals/void",
            params: build_payload(request),
            headers: headers
          )

          PosJournalResponse.from_response(response)
        end

        def self.build_payload(request)
          raise ArgumentError, 'request must respond to :to_h' unless request.respond_to?(:to_h)

          request.to_h
        end

        class CreateRequest < BaseRequest
          ATTRIBUTES = %i[
            batch_date
            change_amt
            country
            coupon_amt
            currency
            customer_name
            discount_amt
            membership_code
            order_at
            original_receipt_num
            pax
            payment_at
            receipt_num
            revenue_center
            room_name
            service_fee_amt
            service_fee_rate
            settle_amt
            site_name
            staff_name
            staff_ref
            subtotal_amt
            system_api_provider
            system_maker
            system_model
            system_version
            table_names
            tax_amt
            tax_included_amt
            tax_rate
            terminal_name
            total_amt
            reservation_ref
            reservation_status
            pos_orders
            pos_payments
            pos_discounts
          ].freeze

          attr_accessor(*ATTRIBUTES)

          def pos_orders=(value)
            @pos_orders = arrays_as(value, PosOrder)
          end

          def pos_payments=(value)
            @pos_payments = arrays_as(value, PosPayment)
          end

          def pos_discounts=(value)
            @pos_discounts = arrays_as(value, PosDiscount)
          end
        end

        class UpdateRequest < CreateRequest
        end

        class VoidRequest < BaseRequest
          ATTRIBUTES = %i[receipt_num void_reason voided_at].freeze
          attr_accessor(*ATTRIBUTES)
        end

        class PosOrder < BaseRequest
          ATTRIBUTES = %i[
            id
            menu_category_name
            menu_category_ref
            menu_item_name
            menu_item_ref
            order_at
            qty
            ref
            sku
            unit_price
          ].freeze

          attr_accessor(*ATTRIBUTES)
        end

        class PosPayment < BaseRequest
          ATTRIBUTES = %i[id amt brand issuer payment_at ref tender].freeze
          attr_accessor(*ATTRIBUTES)
        end

        class PosDiscount < BaseRequest
          ATTRIBUTES = %i[id amt name order_at ref].freeze
          attr_accessor(*ATTRIBUTES)
        end

        class CreateResponse < BaseResponse
          def pos_journal
            body['pos_journal']
          end

          def reservations
            body['reservations'] || []
          end
        end

        class PosJournalResponse < BaseResponse
          def pos_journal
            body['pos_journal']
          end

          def reservations
            body['reservations'] || []
          end
        end

        class DeleteResponse < BaseResponse
        end
      end
    end
  end
end