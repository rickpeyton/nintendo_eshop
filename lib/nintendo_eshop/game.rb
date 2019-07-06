module NintendoEshop
  class Game < APIRequest
    attr_accessor :art
    attr_accessor :categories
    attr_accessor :description
    attr_accessor :esrb
    attr_accessor :id
    attr_accessor :msrp
    attr_accessor :object_id
    attr_accessor :platform
    attr_accessor :release_date
    attr_accessor :sale_price
    attr_accessor :title
    attr_accessor :url

    def initialize(id: nil, object_id: nil)
      self.id = id
      self.object_id = object_id
    end

    def refresh
      response = request(:post, to_json: body)
      result = if response.dig(:hits)&.any?
                 response.dig(:hits, 0)
               elsif response.dig(:results)&.any?
                 response.dig(:results, 0)
               else
                 raise InvalidRequestError, "ID not found"
               end

      refresh_object(result)
      self
    end

    def current_price
      sale_price || msrp
    end

    def release_date_pretty
      release_date.strftime("%b %d, %Y")
    end

    def sale_percent
      ((1 - (sale_price / msrp)).round(2) * 100).to_i.to_s + "%" if sale_price
    end

    class << self
      def retrieve_by(id_type = {})
        validate_argument(id_type)
        instance = new(id_type)
        instance.refresh
      end

    private

      def validate_argument(argument)
        valid_args = argument.keys == [:id] || argument.keys == [:object_id]
        raise InvalidArgumentError, "Only id: and object_id: have been implemented" unless valid_args
      end
    end

  private

    def body
      if id
        query_body
      elsif object_id
        object_body
      end
    end

    def query_body
      {
        "query": id.to_s,
        "restrictSearchableAttributes": [
          "nsuid"
        ]
      }
    end

    def object_body
      {
        "requests": [
          {
            "indexName": "noa_aem_game_en_us",
            "objectID": object_id.to_s,
            "attributesToRetrieve": "boxArt,categories,description,esrb,msrp,nsuid,objectID,platform,releaseDateMask,salePrice,title,url" # rubocop:disable Metrics/LineLength
          }
        ]
      }
    end

    def resource_path
      if id
        "/1/indexes/noa_aem_game_en_us/query".freeze
      elsif object_id
        "/1/indexes/*/objects".freeze
      end
    end

    def refresh_object(result) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      self.art = "https://www.nintendo.com#{result.dig(:boxArt)}"
      self.categories = result.dig(:categories)
      self.description = result.dig(:description).tr("\n", " ").squeeze
      self.esrb = result.dig(:esrb)
      self.id = result.dig(:nsuid)
      self.msrp = result.dig(:msrp)
      self.object_id = result.dig(:objectID)
      self.platform = result.dig(:platform)
      self.release_date = Date.parse(result.dig(:releaseDateMask))
      self.sale_price = result.dig(:salePrice)
      self.title = result.dig(:title)
      self.url = "https://www.nintendo.com#{result.dig(:url)}"
    end
  end
end
