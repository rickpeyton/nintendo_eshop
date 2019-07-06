RSpec.describe NintendoEshop::GamesList do
  it "includes enumerable" do
    expect(NintendoEshop::GamesList).to include(Enumerable)
  end

  describe ".by_title" do
    it "returns a list of games" do
      actual = NintendoEshop::GamesList.by_title("Windscape")
      first_game = actual.first

      expect(actual).to be_a(NintendoEshop::GamesList)
      expect(first_game.title).to eq("Windscape")
      expect(first_game.object_id).not_to be_empty

      expect(first_game.art).to be_a(String).and match(/nintendo.+\.png/)
      expect(first_game.current_price).to be > 0.0
      expect(first_game.id).not_to be_empty
      expect(first_game.msrp).to be > 0.0
      expect(first_game.platform).not_to be_empty
      expect(first_game.sale_price).to be > 0.0
      expect(first_game.title).not_to be_empty
      expect(first_game.url).to be_a(String).and match(/nintendo.+windscape/)
      expect(first_game.sale_percent).not_to be_empty
      expect(first_game.description).not_to be_empty
      expect(first_game.esrb).not_to be_empty
      expect(first_game.categories).not_to be_empty
      expect(first_game.release_date).to be_a(Date)
      expect(first_game.release_date_pretty).not_to be_empty
    end
  end
end
