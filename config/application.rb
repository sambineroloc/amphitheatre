require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Amphitheatre
  class Application < Rails::Application
    config.load_defaults 5.2

    config.generators do |g|
      g.test_framework :rspec
    end

    config.generators.javascript_engine = :js
  end
end
