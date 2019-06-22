module HTTPStubs
  def stub_game_retrieve(game)
    response = File.read("#{__dir__}/#{game}_response.txt")
    stub_request(:post, "#{NintendoEshop.base_url}/1/indexes/*/objects?" \
                        "x-algolia-api-key=#{NintendoEshop.api_key}&x-algolia-application-id=#{NintendoEshop.app_id}")
      .with(
        body: "{\"requests\":[{\"attributesToRetrieve\":\"url,objectID,title,nsuid,salePrice,msrp,boxArt,platform\"," \
              "\"objectID\":\"#{external_key(game)}\",\"indexName\":\"noa_aem_game_en_us\"}]}",
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
      "3ce3fb54-5f95-3a24-9101-7faa694c4b6f"
    when "sonic"
      "26322c64-9268-3a24-822e-5e10f9e5cfc9"
    end
  end
end
