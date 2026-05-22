# frozen_string_literal: true

require "test_helper"

class TableCheckApiPosV1ShopTest < Minitest::Test
  def test_list
    response_body = Struct.new(:body).new(fixture('shops/list.json'))
    mock = Minitest::Mock.new
    mock.expect(:call, response_body, ["/pos/v1/shops"], **{ headers: {} })

    TableCheckApi::Client.stub(:get, mock) do
      response = TableCheckApi::Pos::V1::Shop.list
      assert_instance_of TableCheckApi::Pos::V1::Shop::ListResponse, response
      assert_equal 1, response.shops.size
      assert_equal 'ae5355ca1fd337ed5d6893e2', response.shops.first['id']
    end

    mock.verify
  end

  def test_list_error_returns_api_errors
    response_body = Struct.new(:body).new(fixture('errors/bad_request.json'))
    mock = Minitest::Mock.new
    mock.expect(:call, response_body, ["/pos/v1/shops"], **{ headers: {} })

    TableCheckApi::Client.stub(:get, mock) do
      response = TableCheckApi::Pos::V1::Shop.list
      assert_equal 'parameter_missing', response.raw['errors'].first['code']
      assert_equal 'Required parameter is missing.', response.raw['errors'].first['message']
    end

    mock.verify
  end
end
