# frozen_string_literal: true

require "json"
require "test_helper"

class TableCheckApiPosV1TableTest < Minitest::Test
  def test_list
    response_body = Struct.new(:body).new(fixture('tables/list.json'))
    mock = Minitest::Mock.new
    mock.expect(:call, response_body, ["/pos/v1/shops/shop_123/tables"], **{ headers: {} })

    TableCheckApi::Client.stub(:get, mock) do
      response = TableCheckApi::Pos::V1::Table.list('shop_123')
      assert_instance_of TableCheckApi::Pos::V1::Table::ListResponse, response
      assert_equal 1, response.tables.size
      assert_equal 'ea1fd65d5357ed3ac5893e43', response.tables.first['id']
    end

    mock.verify
  end

  def test_status
    response_body = Struct.new(:body).new(fixture('tables/status_response.json'))
    request_data = JSON.parse(fixture('tables/status_request.json'))
    request = TableCheckApi::Pos::V1::Table::StatusRequest.new(request_data)

    mock = Minitest::Mock.new
    mock.expect(
      :call,
      response_body,
      ["/pos/v1/shops/shop_123/table_status/show"],
      **{ params: request.to_h, headers: {} }
    )

    TableCheckApi::Client.stub(:post, mock) do
      response = TableCheckApi::Pos::V1::Table.status('shop_123', request)
      assert_instance_of TableCheckApi::Pos::V1::Table::StatusResponse, response
      assert_equal 'vacant', response.table_status['status']
      assert_equal 'A1', response.table_status['table_name']
    end

    mock.verify
  end

  def test_status_error_returns_api_errors
    response_body = Struct.new(:body).new(fixture('errors/forbidden.json'))
    request_data = JSON.parse(fixture('tables/status_request.json'))
    request = TableCheckApi::Pos::V1::Table::StatusRequest.new(request_data)

    mock = Minitest::Mock.new
    mock.expect(:call, response_body, ["/pos/v1/shops/shop_123/table_status/show"], **{ params: request.to_h, headers: {} })

    TableCheckApi::Client.stub(:post, mock) do
      response = TableCheckApi::Pos::V1::Table.status('shop_123', request)
      assert_equal 'api_key_invalid', response.raw['errors'].first['code']
      assert_equal 'Your API key is invalid.', response.raw['errors'].first['message']
    end

    mock.verify
  end
end
