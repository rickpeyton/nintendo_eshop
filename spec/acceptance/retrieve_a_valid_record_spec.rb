RSpec.describe "Retrieve a valid game" do
  it "can retrieve a game from the Nintendo API" do
    WebMock.allow_net_connect!
    NintendoEshop.client = NintendoEshop::APIClient

    game = NintendoEshop::Game.retrieve_by(id: "70010000001130")

    expect(game).to be_a NintendoEshop::Game
    expect(game.current_price).to eq(game.msrp).or eq(game.sale_price)
    expect(game.sale_price).to be_a(Integer).or be_nil

    NintendoEshop.client = NintendoEshop::FakeClient
    WebMock.disable_net_connect!
  end
end
