# frozen_string_literal: true

require "test_helper"

class TableCheckApiClientTest < Minitest::Test
  def setup
    TableCheckApi.configure do |config|
      config.base_url = 'https://api.test.com'
      config.key = 'test_key'
    end
  end

  def test_default_headers
    headers = TableCheckApi::Client.default_headers
    assert_equal 'application/json', headers['Accept']
    assert_equal 'application/json', headers['Content-Type']
    assert_equal 'Bearer test_key', headers['Authorization']
  end

  def test_get_merges_headers
    # We use a mock to verify HTTParty receives the correct arguments
    mock = Minitest::Mock.new
    mock.expect(:call, true, ["https://api.test.com/test"], **{ query: {}, headers: { 'User-Agent' => "TableCheckAPIClient-v#{TableCheckApi::VERSION}", 'Accept' => 'application/json', 'Content-Type' => 'application/json', 'Authorization' => 'Bearer override' } })

    HTTParty.stub(:get, mock) do
      TableCheckApi::Client.get("/test", headers: { 'Authorization' => 'Bearer override' })
    end
    mock.verify
  end
end
