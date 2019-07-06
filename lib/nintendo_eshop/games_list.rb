module NintendoEshop
  class GamesList < APIRequest
    include Enumerable

    attr_accessor :title
    attr_accessor :games

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

    def resource_path
      "/1/indexes/noa_aem_game_en_us/query".freeze
    end

    def refresh_list_objects(objects) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      objects.map do |object|
        game = Game.new(id: object.dig(:nsuid))
        game.art = "https://www.nintendo.com#{object.dig(:boxArt)}"
        game.categories = object.dig(:categories)
        game.description = object.dig(:description).tr("\n", " ").squeeze
        game.esrb = object.dig(:esrb)
        game.msrp = object.dig(:msrp)
        game.object_id = object.dig(:objectID)
        game.platform = object.dig(:platform)
        game.release_date = Date.parse(object.dig(:releaseDateMask))
        game.sale_price = object.dig(:salePrice)
        game.title = object.dig(:title)
        game.url = "https://www.nintendo.com#{object.dig(:url)}"
        game
      end
    end
  end
end
