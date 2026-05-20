# frozen_string_literal: true

require "test_helper"

class TableCheckApiPosV1PosJournalsTest < Minitest::Test
  def test_create
    mock = Minitest::Mock.new
    mock.expect(:call, true, ["/pos/v1/shops/shop_123/pos_journals"], **{ params: { amount: 100 }, headers: {} })

    TableCheckApi::Client.stub(:post, mock) do
      TableCheckApi::Pos::V1::PosJournals.create('shop_123', { amount: 100 })
    end

    mock.verify
  end

  def test_update
    mock = Minitest::Mock.new
    mock.expect(:call, true, ["/pos/v1/shops/shop_123/pos_journals/1"], **{ params: { amount: 200 }, headers: {} })

    TableCheckApi::Client.stub(:post, mock) do
      TableCheckApi::Pos::V1::PosJournals.update('shop_123', 1, { amount: 200 })
    end

    mock.verify
  end

  def test_delete
    mock = Minitest::Mock.new
    mock.expect(:call, true, ["/pos/v1/shops/shop_123/pos_journals/1"], **{ params: { _method: 'delete' }, headers: {} })

    TableCheckApi::Client.stub(:post, mock) do
      TableCheckApi::Pos::V1::PosJournals.delete('shop_123', 1)
    end

    mock.verify
  end

  def test_void
    mock = Minitest::Mock.new
    mock.expect(:call, true, ["/pos/v1/shops/shop_123/pos_journals/void"], **{ params: { reason: 'mistake' }, headers: {} })

    TableCheckApi::Client.stub(:post, mock) do
      TableCheckApi::Pos::V1::PosJournals.void('shop_123', { reason: 'mistake' })
    end

    mock.verify
  end
end
