RSpec.describe NintendoEshop::GamesList do
  it "includes enumerable" do
    expect(NintendoEshop::GamesList).to include(Enumerable)
  end

  describe ".by_title" do
    it "returns a list of games" do
      actual = NintendoEshop::GamesList.by_title("Mario")
      first_game = actual.first

      expect(actual).to be_a(NintendoEshop::GamesList)
      expect(first_game.title).to eq("Dr. Mario World")
      expect(first_game.object_id).not_to be_nil
    end
  end
end
