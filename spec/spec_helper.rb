require "simplecov"
SimpleCov.start

require "bundler/setup"
require "nintendo_eshop"

require_relative "http_stubs/http_stubs"

require "webmock/rspec"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def setup
  NintendoEshop.base_url = "https://u3b6gr4ua3-dsn.algolia.net"
  NintendoEshop.api_key = "9a20c93440cf63cf1a7008d75f7438bf"
  NintendoEshop.app_id = "U3B6GR4UA3"
end

setup
