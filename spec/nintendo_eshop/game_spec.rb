RSpec.describe NintendoEshop::Game do
  describe ".retrieve" do
    it "retrieves a sale game from the Nintendo eShop API" do
      extend HTTPStubs
      stub_game_retrieve("sonic")
      game = NintendoEshop::Game.retrieve("26322c64-9268-3a24-822e-5e10f9e5cfc9")

      expect(game).to be_a NintendoEshop::Game
      expect(game.art).to eq "/content/dam/noa/en_US/games/switch/s/sonic-forces-switch/Switch_SonicForces_box.png"
      expect(game.current_price).to eq 14.99
      expect(game.external_key).to eq "26322c64-9268-3a24-822e-5e10f9e5cfc9"
      expect(game.id).to eq "70010000001539"
      expect(game.msrp).to eq 29.99
      expect(game.platform).to eq "Nintendo Switch"
      expect(game.sale_price).to eq 14.99
      expect(game.title).to eq "Sonic Forces"
      expect(game.url).to eq "/games/detail/sonic-forces-switch"
    end

    it "retrieves a non-sale game from the Nintendo eShop API" do
      extend HTTPStubs
      stub_game_retrieve("mario")
      game = NintendoEshop::Game.retrieve("3ce3fb54-5f95-3a24-9101-7faa694c4b6f")

      expect(game).to be_a NintendoEshop::Game
      expect(game.art).to match(%r{/Switch_SuperMarioOdyssey_box.png})
      expect(game.current_price).to eq 59.99
      expect(game.external_key).to eq "3ce3fb54-5f95-3a24-9101-7faa694c4b6f"
      expect(game.id).to eq "70010000001130"
      expect(game.msrp).to eq 59.99
      expect(game.platform).to eq "Nintendo Switch"
      expect(game.sale_price).to eq nil
      expect(game.title).to eq "Super Mario Odyssey"
      expect(game.url).to eq "/games/detail/super-mario-odyssey-switch"
    end
  end
end
