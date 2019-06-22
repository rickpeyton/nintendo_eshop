# Nintendo eShop

## Description

When I want to check the price of a game on the Nintendo eShop I want to search Nintendo's API by external key so that I am confident I am getting the correct price.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nintendo_eshop'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nintendo_eshop

## Usage

```ruby
game = NintendoEshop::Game.retrieve("26322c64-9268-3a24-822e-5e10f9e5cfc9")

game.url # "/games/detail/sonic-forces-switch"
game.title # "Sonic Forces"
game.id # "70010000001539"
game.art # "/content/dam/noa/en_US/games/switch/s/sonic-forces-switch/Switch_SonicForces_box.png"
game.platform # "Nintendo Switch"
game.msrp # 29.99
game.sale_price # 14.99
game.current_price # 14.99
game.external_key # "26322c64-9268-3a24-822e-5e10f9e5cfc9
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rickpeyton/nintendo_eshop.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
