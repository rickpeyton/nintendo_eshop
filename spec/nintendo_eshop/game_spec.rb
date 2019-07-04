RSpec.describe NintendoEshop::Game do
  describe ".retrieve" do
    it "retrieves a sale game from the Nintendo eShop API" do
      game = NintendoEshop::Game.retrieve_by(id: "70010000001539")

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
      game = NintendoEshop::Game.retrieve_by(id: "70010000001130")

      expect(game).to be_a NintendoEshop::Game
      expect(game.current_price).to eq game.msrp
      expect(game.sale_price).to eq nil
    end

    it "raises an invalid request if a game is not found" do
      game = -> { NintendoEshop::Game.retrieve_by(id: "invalid") }

      expect { game.call }.to raise_error(NintendoEshop::InvalidRequestError, "ID not found")
    end
  end

  it "retrieves a game via the object id" do
    game = NintendoEshop::Game.retrieve_by(object_id: "26851cb3-4f10-333a-8d7c-f9cae4a9bc03")

    expect(game).to be_a NintendoEshop::Game
    expect(game.art).to eq "/content/dam/noa/en_US/games/switch/b/bridge-constructor-portal-switch/Switch_BridgeConstructorPortal_box_eShop.png"
    expect(game.current_price).to eq 7.49
    expect(game.id).to eq "70010000001023"
    expect(game.msrp).to eq 14.99
    expect(game.object_id).to eq "26851cb3-4f10-333a-8d7c-f9cae4a9bc03"
    expect(game.platform).to eq "Nintendo Switch"
    expect(game.sale_price).to eq 7.49
    expect(game.title).to eq "Bridge Constructor Portal"
    expect(game.url).to eq "/games/detail/bridge-constructor-portal-switch"
  end
end
