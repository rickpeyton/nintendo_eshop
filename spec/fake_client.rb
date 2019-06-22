module NintendoEshop
  class FakeClient
    class << self
      def post(_uri, json: {})
        response = case json.dig(:query)
                   when "70010000001539"
                     File.read("spec/http_stubs/sonic_response.txt")
                   when "70010000001130"
                     File.read("spec/http_stubs/mario_response.txt")
                   end
        OpenStruct.new(
          body: response
        )
      end
    end
  end
end
