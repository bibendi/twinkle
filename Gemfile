source "https://rubygems.org"

gem "rails", "4.2.6"
gem "sass-rails"
gem "uglifier"
gem "therubyracer", platforms: :ruby
gem "hiredis"
gem "redis", require: ["redis", "redis/connection/hiredis"]
gem "ohm"
gem "ohm-contrib"
gem "telegram-bot-ruby"
gem "interactor"
gem "resque", "~> 1.26"
gem "resque-web", require: "resque_web"

gem "unicorn", group: :production

group :development, :test do
  gem "dotenv-rails"
end
