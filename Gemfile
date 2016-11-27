source "https://rubygems.org"

gem "rails"
gem "puma"
gem "pg"
gem "jsonb_accessor"
gem "omniauth-github"
gem "octokit"
gem "sass-rails"
# https://github.com/metaskills/less-rails/issues/122
gem "less-rails", git: "https://github.com/MustafaZain/less-rails"
gem "twitter-bootstrap-rails"
gem "haml"
gem "haml-rails"
gem "autoprefixer-rails"
gem "turbolinks"
gem "uglifier"
gem "therubyracer", platforms: :ruby
gem "redis"
gem "findit"
gem "telegram-bot-ruby"
gem "interactor"
gem "gretel"

gem "resque"
gem "resque-web", require: "resque_web"

group :production do
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

group :development, :test do
  gem "pry-rails"
  gem "pry-byebug"
end
