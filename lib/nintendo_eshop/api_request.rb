module NintendoEshop
  class APIRequest
    class << self; end

  private

    def request(method, to_json: {})
      case method
      when :post
        post(to_json: to_json)
      end
    end

    def post(to_json: {})
      uri = URI("#{NintendoEshop.base_url}#{self.class::RESOURCE_PATH}?#{url_params}")
      http = setup_http(uri)
      req = Net::HTTP::Post.new(uri)
      req.add_field "Accept", "application/json"
      req.add_field "Content-Type", "application/json"
      req.body = JSON.dump(to_json)
      res = http.request(req)
      JSON.parse(res.body, symbolize_names: true)
    end

    def setup_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http
    end

    def url_params
      "x-algolia-api-key=#{NintendoEshop.api_key}&x-algolia-application-id=#{NintendoEshop.app_id}"
    end
  end
end
