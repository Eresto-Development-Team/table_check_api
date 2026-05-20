# frozen_string_literal: true

require "test_helper"

class TableCheckApiPosV1TableTest < Minitest::Test
  def test_list
    mock = Minitest::Mock.new
    mock.expect(:call, true, ["/pos/v1/shops/shop_123/tables"], **{ headers: {} })

    TableCheckApi::Client.stub(:get, mock) do
      TableCheckApi::Pos::V1::Table.list('shop_123')
    end

    mock.verify
  end

  def test_status
    mock = Minitest::Mock.new
    mock.expect(:call, true, ["/pos/v1/shops/shop_123/table_status/show"], **{ headers: {} })

    TableCheckApi::Client.stub(:get, mock) do
      TableCheckApi::Pos::V1::Table.status('shop_123')
    end

    mock.verify
  end
end
