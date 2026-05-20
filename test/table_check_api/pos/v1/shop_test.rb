# frozen_string_literal: true

require "test_helper"

class TableCheckApiPosV1ShopTest < Minitest::Test
  def test_list
    mock = Minitest::Mock.new
    mock.expect(:call, true, ["/pos/v1/shops"], **{ headers: {} })

    TableCheckApi::Client.stub(:get, mock) do
      TableCheckApi::Pos::V1::Shop.list
    end

    mock.verify
  end
end
