# frozen_string_literal: true

require_relative './pos/v1/shop'
require_relative './pos/v1/table'
require_relative './pos/v1/pos_journals'

module TableCheck
  module Api
    class Engine < ::Rails::Engine
      isolate_namespace TableCheck::Api
    end
  end
end