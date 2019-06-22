module NintendoEshop
  class APIClient
    class << self
      def post(uri, json: {})
        http = setup_http(uri)
        req = Net::HTTP::Post.new(uri)
        req.add_field "Accept", "application/json"
        req.add_field "Content-Type", "application/json"
        req.body = JSON.dump(json)
        http.request(req)
      end

      def setup_http(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http
      end
    end
  end
end
