module HTTPStubs
  def stub_game_retrieve(game)
    response = File.read("#{__dir__}/#{game}_response.txt")
    stub_request(:post, "#{NintendoEshop.base_url}/1/indexes/noa_aem_game_en_us/query" \
                        "?x-algolia-api-key=#{NintendoEshop.api_key}&x-algolia-application-id=#{NintendoEshop.app_id}")
      .with(
        body: "{\"query\":\"#{external_key(game)}\",\"restrictSearchableAttributes\":[\"nsuid\"]}",
        headers: {
          "Accept" => ["*/*", "application/json"],
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Content-Type" => "application/json",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: response, headers: { "Content-Type" => "application/json; charset=UTF-8" })
  end

private

  def external_key(game)
    case game
    when "mario"
      "70010000001130"
    when "sonic"
      "70010000001539"
    end
  end
end
