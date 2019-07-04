# Nintendo eShop

[![Gem Version](https://badge.fury.io/rb/nintendo_eshop.svg)](https://badge.fury.io/rb/nintendo_eshop)
[![CircleCI](https://circleci.com/gh/rickpeyton/nintendo_eshop.svg?style=svg)](https://circleci.com/gh/rickpeyton/nintendo_eshop)
[![Maintainability](https://api.codeclimate.com/v1/badges/5e41e08d88dbecfcf318/maintainability)](https://codeclimate.com/github/rickpeyton/nintendo_eshop/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/5e41e08d88dbecfcf318/test_coverage)](https://codeclimate.com/github/rickpeyton/nintendo_eshop/test_coverage)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&identifier=193173552)](https://dependabot.com)

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

Use the provided `base_url`, `api_key` and `app_id`. These are provided as configuration in case the values change. The README will be updated to reflect the new values so that you do not have to update the library.

```ruby
NintendoEshop.base_url = "https://u3b6gr4ua3-dsn.algolia.net"
NintendoEshop.api_key = "9a20c93440cf63cf1a7008d75f7438bf"
NintendoEshop.app_id = "U3B6GR4UA3"

### Retrieve a game by ID (nsuid)

game = NintendoEshop::Game.retrieve_by(id: "70010000001130")

game.art # "/content/dam/noa/en_US/games/switch/s/super-mario-odyssey-switch/Switch_SuperMarioOdyssey_box.png"
game.current_price # 59.99
game.id # "70010000001130"
game.msrp # 59.99
game.object_id # 3ce3fb54-5f95-3a24-9101-7faa694c4b6f
game.platform # "Nintendo Switch"
game.sale_price # nil
game.title # Super Mario Odyssey"
game.url # "/games/detail/super-mario-odyssey-switch"
```

Or a game on sale

```ruby
game = NintendoEshop::Game.retrieve_by(id: "70010000001539")

game.art # "/content/dam/noa/en_US/games/switch/s/sonic-forces-switch/Switch_SonicForces_box.png"
game.current_price # 14.99
game.id # "70010000001539"
game.msrp # 29.99
game.object_id # 26322c64-9268-3a24-822e-5e10f9e5cfc9
game.platform # "Nintendo Switch"
game.sale_price # 14.99
game.title # "Sonic Forces"
game.url # "/games/detail/sonic-forces-switch"
```

Or by object_id

```ruby
game = NintendoEshop::Game.retrieve_by(object_id: "26851cb3-4f10-333a-8d7c-f9cae4a9bc03")

game.id # "70010000001023"
game.object_id # "26851cb3-4f10-333a-8d7c-f9cae4a9bc03"
game.art # "/content/dam/noa/en_US/games/switch/b/bridge-constructor-portal-switch/Switch_BridgeConstructorPortal_box_eShop.png"
game.msrp # 14.99
game.platform # "Nintendo Switch"
game.sale_price # 7.49
game.title # "Bridge Constructor Portal"
game.url # "/games/detail/bridge-constructor-portal-switch"
```

### Search by Title

```ruby
games = NintendoEshop::GamesList.by_title("Super Mario Odyssey")

games.first.title # "Super Mario Odyssey: Starter"
```

## Errors

Error handling is still a work in progress

```ruby
game = NintendoEshop::Game.retrieve_by(id: "invalid id")

# => NintendoEshop::InvalidRequestError
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rickpeyton/nintendo_eshop.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Releases

CircleCi is used to push releases to rubygems.org

To release

* Edit the version.rb file
* `bundle`
* Commit that to your master branch
* Create and push a git tag with the same name as your version

Example

```
git tag -a 0.1.0
git push origin 0.1.0
```
