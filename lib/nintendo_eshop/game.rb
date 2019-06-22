module NintendoEshop
  class Game < APIRequest
    attr_accessor :art
    attr_accessor :external_key
    attr_accessor :id
    attr_accessor :msrp
    attr_accessor :platform
    attr_accessor :sale_price
    attr_accessor :title
    attr_accessor :url

    RESOURCE_PATH = "/1/indexes/*/objects".freeze

    def initialize(external_key)
      self.external_key = external_key
    end

    def refresh
      response = request(:post, to_json: body)
      result = response.dig(:results, 0)
      refresh_object(result)
      self
    end

    def current_price
      sale_price || msrp
    end

    def self.retrieve(external_key)
      instance = new(external_key)
      instance.refresh
    end

  private

    def body
      {
        "requests" => [
          {
            "attributesToRetrieve" => "url,objectID,title,nsuid,salePrice,msrp,boxArt,platform",
            "objectID" => external_key.to_s,
            "indexName" => "noa_aem_game_en_us"
          }
        ]
      }
    end

    def refresh_object(result)
      self.art = result.dig(:boxArt)
      self.external_key = result.dig(:objectID)
      self.id = result.dig(:nsuid)
      self.msrp = result.dig(:msrp)
      self.platform = result.dig(:platform)
      self.sale_price = result.dig(:salePrice)
      self.title = result.dig(:title)
      self.url = result.dig(:url)
    end
  end
end
