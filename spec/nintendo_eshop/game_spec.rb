RSpec.describe NintendoEshop::Game do
  describe ".retrieve" do
    it "retrieves a sale game from the Nintendo eShop API" do
      game = NintendoEshop::Game.retrieve("70010000001539")

      expect(game).to be_a NintendoEshop::Game
      expect(game.art).to eq "/content/dam/noa/en_US/games/switch/s/sonic-forces-switch/Switch_SonicForces_box.png"
      expect(game.current_price).to eq 14.99
      expect(game.id).to eq "70010000001539"
      expect(game.msrp).to eq 29.99
      expect(game.object_id).to eq "26322c64-9268-3a24-822e-5e10f9e5cfc9"
      expect(game.platform).to eq "Nintendo Switch"
      expect(game.sale_price).to eq 14.99
      expect(game.title).to eq "Sonic Forces"
      expect(game.url).to eq "/games/detail/sonic-forces-switch"
    end

    it "retrieves a non-sale game from the Nintendo eShop API" do
      game = NintendoEshop::Game.retrieve("70010000001130")

      expect(game).to be_a NintendoEshop::Game
      expect(game.current_price).to eq game.msrp
      expect(game.sale_price).to eq nil
    end

    it "raises an invalid request if a game is not found" do
      game = -> { NintendoEshop::Game.retrieve("invalid") }

      expect { game.call }.to raise_error(NintendoEshop::InvalidRequestError, "ID not found")
    end
  end
end
