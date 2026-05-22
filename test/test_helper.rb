# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "table_check_api"
require "minitest/autorun"
require "minitest/mock"

# Common test helpers can be added here

def fixture_path(relative_path)
  File.expand_path(File.join("fixtures", relative_path), __dir__)
end

def fixture(relative_path)
  File.read(fixture_path(relative_path))

rescue Errno::ENOENT
  raise "Fixture not found: #{relative_path}"
end
