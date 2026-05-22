# frozen_string_literal: true

require "test_helper"

class TableCheckApiPosV1PosJournalsTest < Minitest::Test
  def test_create
    request = TableCheckApi::Pos::V1::PosJournals::CreateRequest.new(
      batch_date: '2020-01-01',
      country: 'JP',
      currency: 'JPY',
      receipt_num: 'string'
    )

    response_body = Struct.new(:body).new(fixture('pos_journals/create_response.json'))
    mock = Minitest::Mock.new
    mock.expect(
      :call,
      response_body,
      ["/pos/v1/shops/shop_123/pos_journals"],
      **{ params: request.to_h, headers: {} }
    )

    TableCheckApi::Client.stub(:post, mock) do
      response = TableCheckApi::Pos::V1::PosJournals.create('shop_123', request)
      assert_instance_of TableCheckApi::Pos::V1::PosJournals::CreateResponse, response
      assert_equal 'ae5355ca1fd337ed5d6893e2', response.pos_journal['id']
    end

    mock.verify
  end

  def test_update
    request = TableCheckApi::Pos::V1::PosJournals::UpdateRequest.new(
      receipt_num: 'string',
      pos_payments: [
        {
          id: 'payment_1',
          amt: '2000'
        }
      ]
    )

    response_body = Struct.new(:body).new(fixture('pos_journals/update_response.json'))
    mock = Minitest::Mock.new
    mock.expect(
      :call,
      response_body,
      ["/pos/v1/shops/shop_123/pos_journals/1"],
      **{ params: request.to_h, headers: {} }
    )

    TableCheckApi::Client.stub(:put, mock) do
      response = TableCheckApi::Pos::V1::PosJournals.update('shop_123', 1, request)
      assert_instance_of TableCheckApi::Pos::V1::PosJournals::PosJournalResponse, response
      assert_equal({}, response.body)
    end

    mock.verify
  end

  def test_delete
    response_body = Struct.new(:body).new(fixture('pos_journals/delete_response.json'))
    mock = Minitest::Mock.new
    mock.expect(:call, response_body, ["/pos/v1/shops/shop_123/pos_journals/1"], **{ headers: {} })

    TableCheckApi::Client.stub(:delete, mock) do
      response = TableCheckApi::Pos::V1::PosJournals.delete('shop_123', 1)
      assert_instance_of TableCheckApi::Pos::V1::PosJournals::DeleteResponse, response
      assert_equal 'ok', response.body['status']
    end

    mock.verify
  end

  def test_void
    request = TableCheckApi::Pos::V1::PosJournals::VoidRequest.new(
      receipt_num: '12345',
      void_reason: 'customer_cancellation',
      voided_at: '2026-01-29T19:30:00Z'
    )

    response_body = Struct.new(:body).new(fixture('pos_journals/void_response.json'))
    mock = Minitest::Mock.new
    mock.expect(
      :call,
      response_body,
      ["/pos/v1/shops/shop_123/pos_journals/void"],
      **{ params: request.to_h, headers: {} }
    )

    TableCheckApi::Client.stub(:post, mock) do
      response = TableCheckApi::Pos::V1::PosJournals.void('shop_123', request)
      assert_instance_of TableCheckApi::Pos::V1::PosJournals::PosJournalResponse, response
      assert_equal 'ok', response.body['status']
    end

    mock.verify
  end

  def test_error_response_parses_user_errors
    request = TableCheckApi::Pos::V1::PosJournals::CreateRequest.new(
      batch_date: '2020-01-01',
      receipt_num: '12345'
    )

    response_body = Struct.new(:body).new(fixture('errors/unprocessable_entity.json'))
    mock = Minitest::Mock.new
    mock.expect(
      :call,
      response_body,
      ["/pos/v1/shops/shop_123/pos_journals"],
      **{ params: request.to_h, headers: {} }
    )

    TableCheckApi::Client.stub(:post, mock) do
      response = TableCheckApi::Pos::V1::PosJournals.create('shop_123', request)
      assert_equal 'not_created', response.body['errors'].first['code']
      assert_equal 'Could not create resource due to missing parameter.', response.body['errors'].first['message']
    end

    mock.verify
  end
end
