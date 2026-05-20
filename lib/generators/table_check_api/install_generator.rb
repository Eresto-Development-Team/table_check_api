# frozen_string_literal: true

require 'rails/generators/base'

module TableCheckApi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../templates", __FILE__)

      desc "Creates TableCheck API initializer."

      def copy_tablecheck_api_initializer
        template "table_check_api.rb", "config/initializers/table_check_api.rb"
      end
    end
  end
end