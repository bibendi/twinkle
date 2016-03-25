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

gem "unicorn", group: :production

group :test do
  gem "rspec-rails"
  gem "mock_redis"
  gem "factory_girl_rails"
  gem "resque_spec"
  gem "simplecov", require: false
  gem "codeclimate-test-reporter", require: false
end
