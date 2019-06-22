module NintendoEshop
  class Game < APIRequest
    attr_accessor :art
    attr_accessor :id
    attr_accessor :msrp
    attr_accessor :platform
    attr_accessor :sale_price
    attr_accessor :title
    attr_accessor :url

    RESOURCE_PATH = "/1/indexes/noa_aem_game_en_us/query".freeze

    def initialize(id)
      self.id = id
    end

    def refresh
      response = request(:post, to_json: body)
      result = response.dig(:hits, 0)
      refresh_object(result)
      self
    end

    def current_price
      sale_price || msrp
    end

    def self.retrieve(id)
      instance = new(id)
      instance.refresh
    end

  private

    def body
      {
        "query": id.to_s,
        "restrictSearchableAttributes": [
          "nsuid"
        ]
      }
    end

    def refresh_object(result)
      self.art = result.dig(:boxArt)
      self.id = result.dig(:nsuid)
      self.msrp = result.dig(:msrp)
      self.platform = result.dig(:platform)
      self.sale_price = result.dig(:salePrice)
      self.title = result.dig(:title)
      self.url = result.dig(:url)
    end
  end
end
