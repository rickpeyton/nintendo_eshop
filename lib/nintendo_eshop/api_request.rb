module NintendoEshop
  class APIRequest
    class << self; end

  private

    def request(method, to_json: {})
      case method
      when :post
        post(json: to_json)
      end
    end

    def post(json: {})
      uri = URI("#{NintendoEshop.base_url}#{resource_path}?#{url_params}")
      response = NintendoEshop.client.post(uri, json: json)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      parsed_response
    end

    def url_params
      "x-algolia-api-key=#{NintendoEshop.api_key}&x-algolia-application-id=#{NintendoEshop.app_id}"
    end
  end
end
