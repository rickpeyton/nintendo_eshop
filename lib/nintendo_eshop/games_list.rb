module NintendoEshop
  class GamesList < APIRequest
    include Enumerable

    attr_accessor :title
    attr_accessor :games

    RESOURCE_PATH = "/1/indexes/noa_aem_game_en_us/query".freeze

    def initialize(title)
      self.title = title
    end

    def refresh
      response = request(:post, to_json: body)
      result = response.dig(:hits)
      self.games = refresh_list_objects(result)
      self
    end

    def each
      games.each do |game|
        yield(game)
      end
    end

    def self.by_title(title)
      instance = new(title)
      instance.refresh
    end

  private

    def body
      {
        "query": title.to_s,
        "restrictSearchableAttributes": [
          "title"
        ]
      }
    end

    def refresh_list_objects(objects)
      objects.map do |object|
        game = Game.new(object.dig(:nsuid))
        game.art = object.dig(:boxArt)
        game.msrp = object.dig(:msrp)
        game.platform = object.dig(:platform)
        game.sale_price = object.dig(:salePrice)
        game.title = object.dig(:title)
        game.url = object.dig(:url)
        game
      end
    end
  end
end
