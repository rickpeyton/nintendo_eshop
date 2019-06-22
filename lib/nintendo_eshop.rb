begin
  require "pry"
rescue StandardError; end # rubocop:disable Lint/HandleExceptions
require "json"
require "net/http"

require_relative "nintendo_eshop/api_request"
require_relative "nintendo_eshop/game"
require_relative "nintendo_eshop/version"

module NintendoEshop
  class << self
    attr_accessor :api_key
    attr_accessor :app_id
    attr_accessor :base_url
  end

  class Error < StandardError; end
end
