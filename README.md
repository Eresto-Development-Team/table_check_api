# TableCheck API Ruby Gem

[![Test](https://github.com/Eresto-Development-Team/table_check_api/actions/workflows/test.yml/badge.svg)](https://github.com/Eresto-Development-Team/table_check_api/actions/workflows/test.yml)

A Ruby wrapper for the TableCheck POS v1 API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'table_check_api'
```

And then execute:

    $ bundle install

## Configuration

Run the generator to create the initializer:

    $ rails generate table_check_api:install

Configure it in `config/initializers/table_check_api.rb`:

```ruby
TableCheckApi.configure do |config|
  config.base_url = 'https://api.tablecheck.com/api'
  config.key = 'your_api_key_here'
end
```

## Usage

### List shops

```ruby
response = TableCheckApi::Pos::V1::Shop.list
shops = response.shops
puts shops.first['id']
```

### List tables for a shop

```ruby
response = TableCheckApi::Pos::V1::Table.list('shop_123')
tables = response.tables
puts tables.first['name']
```

### Get table status

```ruby
request = TableCheckApi::Pos::V1::Table::StatusRequest.new(
  table_id: 'ae5355ca1fd337ed5d6893e2',
  time: '2020-01-29T19:00:00Z'
)

response = TableCheckApi::Pos::V1::Table.status('shop_123', request)
status = response.table_status
puts status['status']
```

### Create POS journal

```ruby
request = TableCheckApi::Pos::V1::PosJournals::CreateRequest.new(
  batch_date: '2020-01-01',
  country: 'JP',
  currency: 'JPY',
  receipt_num: 'string',
  pos_orders: [
    {
      id: 'order_1',
      menu_category_name: 'Appetizer',
      menu_item_name: 'Chicken Soup',
      qty: 1,
      unit_price: '1000'
    }
  ]
)

response = TableCheckApi::Pos::V1::PosJournals.create('shop_123', request)
pos_journal = response.pos_journal
puts pos_journal['id']
```

### Update POS journal

```ruby
request = TableCheckApi::Pos::V1::PosJournals::UpdateRequest.new(
  receipt_num: 'string',
  pos_payments: [
    {
      id: 'payment_1',
      amt: '2000'
    }
  ]
)

response = TableCheckApi::Pos::V1::PosJournals.update('shop_123', 1, request)
pos_journal = response.pos_journal
```

### Delete POS journal

```ruby
response = TableCheckApi::Pos::V1::PosJournals.delete('shop_123', 1)
puts response.body['status']
```

### Void POS journal

```ruby
request = TableCheckApi::Pos::V1::PosJournals::VoidRequest.new(
  receipt_num: '12345',
  void_reason: 'customer_cancellation',
  voided_at: '2026-01-29T19:30:00Z'
)

response = TableCheckApi::Pos::V1::PosJournals.void('shop_123', request)
pos_journal = response.pos_journal
```

## Documentation

See the [AGENT.md](AGENT.md) for detailed architecture, endpoints, and usage examples.
