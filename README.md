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

## Documentation

See the [AGENT.md](AGENT.md) for detailed architecture, endpoints, and usage examples.
