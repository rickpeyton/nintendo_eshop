lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nintendo_eshop/version"

Gem::Specification.new do |spec|
  spec.name          = "nintendo_eshop"
  spec.version       = NintendoEshop::VERSION
  spec.authors       = ["Rick Peyton"]
  spec.email         = ["peytorb@gmail.com"]

  spec.summary       = "Retrieve game prices from the Nintendo eShop"
  spec.description = <<~DESCRIPTION
    When I want to check the price of a game on the Nintendo eShop I want to search Nintendo's
    API by external key so that I am confident I am getting the correct price.
  DESCRIPTION
  spec.homepage = "https://github.com/rickpeyton/nintendo_eshop"
  spec.metadata = {
    "changelog_uri" => "https://github.com/rickpeyton/nintendo_eshop/releases",
    "homepage_uri" => "https://github.com/rickpeyton/nintendo_eshop",
    "source_code_uri" => "https://github.com/rickpeyton/nintendo_eshop"
  }
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.4.6"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "debase"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter"
  spec.add_development_dependency "rubocop", "~> 0.74.0"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "ruby-debug-ide"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "solargraph"
  spec.add_development_dependency "webmock"
end
