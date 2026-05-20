# frozen_string_literal: true

require_relative "version"

module TableCheckApi
  # Pure Ruby module-level accessors for gem configuration.
  # No ActiveSupport dependency required.
  #
  # Usage:
  #   TableCheckApi.configure do |config|
  #     config.base_url = 'https://api.tablecheck.com/api'
  #     config.key = 'your_api_key'
  #   end
  module Configuration
    attr_accessor :base_url, :key

    def configure
      yield self
    end
  end

  extend Configuration

  # Set defaults
  self.base_url = 'https://api.tablecheck.com/api'
  self.key = ''
end