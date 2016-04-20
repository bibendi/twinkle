source "https://rubygems.org"

gem "rails"
gem "dotenv-rails"
gem "pg"
gem "jsonb_accessor"
gem "sass-rails"
gem "uglifier"
gem "therubyracer", platforms: :ruby
gem "hiredis"
gem "redis", require: ["redis", "redis/connection/hiredis"]
gem "telegram-bot-ruby"
gem "interactor"
gem "resque"
gem "resque-web", require: "resque_web"

group :production do
  gem "unicorn"
  gem "newrelic_rpm"
end

group :test do
  gem "rspec-rails"
  gem "mock_redis"
  gem "factory_girl_rails"
  gem "resque_spec"
  gem "simplecov", require: false
  gem "codeclimate-test-reporter", require: false
end
