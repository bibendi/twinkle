require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Twinkle
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.active_record.schema_format = :sql

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'UTC'
    config.active_record.default_timezone = :utc

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.api_only = false

    config.twinkle = ActiveSupport::OrderedOptions.new

    config.twinkle.github = ActiveSupport::OrderedOptions.new
    config.twinkle.github.organization = ENV["GITHUB_ORGANIZATION"]
    config.twinkle.github.admin_team = ENV["GITHUB_ADMIN_TEAM"]
    config.twinkle.github.client_id = ENV["GITHUB_CLIENT_ID"]
    config.twinkle.github.client_secret = ENV["GITHUB_CLIENT_SECRET"]

    config.twinkle.telegram = ActiveSupport::OrderedOptions.new
    config.twinkle.telegram.bot_token = ENV["TELEGRAM_BOT_TOKEN"]
  end
end
