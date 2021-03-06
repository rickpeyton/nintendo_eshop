begin
  require "pry"
rescue Exception; end # rubocop:disable Lint/HandleExceptions, Lint/RescueException
require "date"
require "json"
require "net/http"

require_relative "nintendo_eshop/api_client"
require_relative "nintendo_eshop/api_request"
require_relative "nintendo_eshop/game"
require_relative "nintendo_eshop/games_list"
require_relative "nintendo_eshop/version"

module NintendoEshop
  class << self
    attr_accessor :api_key
    attr_accessor :app_id
    attr_accessor :base_url

    attr_writer :client

    def client
      @client ||= NintendoEshop::APIClient
    end
  end

  class Error < StandardError; end
  class InvalidArgumentError < Error; end
  class InvalidRequestError < Error; end
end
