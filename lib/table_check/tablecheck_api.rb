# frozen_string_literal: true

require "table_check/api/version"
require "table_check/api/engine"

module TableCheck::Api
  mattr_accessor :base_url
  @@base_url = 'https://api.tablecheck.com/api'

  # TODO: can be set dynamically on API call
  mattr_accessor :key
  @@key = ''

  def self.configure
    yield self
  end
end