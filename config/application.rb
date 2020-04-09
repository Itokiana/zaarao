require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Zarao
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    Bundler.require(*Rails.groups)

    Dotenv::Railtie.load

    HOSTNAME = ENV['HOSTNAME']

    config.i18n.available_locales = [:mg, :en, :fr]
    config.i18n.default_locale = :fr
  end
end
