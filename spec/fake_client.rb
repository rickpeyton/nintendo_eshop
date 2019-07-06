module NintendoEshop
  class FakeClient
    class << self
      def post(_uri, json: {})
        response = case json.dig(:query)
                   when "70010000001539"
                     File.read("spec/http_responses/sonic_response.txt")
                   when "70010000001130"
                     File.read("spec/http_responses/mario_response.txt")
                   when "invalid"
                     File.read("spec/http_responses/invalid_response.txt")
                   when "Windscape"
                     File.read("spec/http_responses/windscape_games_list_response.txt")
                   when nil
                     File.read("spec/http_responses/bridge_constructor_portal_response.txt")
                   end
        OpenStruct.new(
          body: response
        )
      end
    end
  end
end
