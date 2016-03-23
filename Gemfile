source "https://rubygems.org"

gem "rails", "4.2.6"
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
gem "resque", "~> 1.26"
gem "resque-web", require: "resque_web"

gem "unicorn", group: :production

group :test do
  gem "rspec-rails"
  gem "mock_redis"
  gem "simplecov", require: false
end
