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

    def refresh_list_objects(objects)
      objects.map do |object|
        game = Game.new(id: object.dig(:nsuid))
        game.send(:refresh_object, object)
        game
      end
    end
  end
end
