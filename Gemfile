source "https://rubygems.org"

gem "rails"
gem "rails-api"
gem "puma"
gem "pg"
gem "jsonb_accessor"
gem "omniauth-github"
gem "octokit"
gem "faraday-http-cache"
gem "sass-rails"
# https://github.com/metaskills/less-rails/issues/122
gem "less-rails", git: "https://github.com/MustafaZain/less-rails"
gem "twitter-bootstrap-rails"
gem "haml"
gem "haml-rails"
gem "jbuilder"
gem "autoprefixer-rails"
gem "turbolinks"
gem "uglifier"
gem "therubyracer", platforms: :ruby
gem "redis"
gem "findit"
gem "active_hash"
gem "telegram-bot-ruby"
gem "interactor"
gem "gretel"
gem "knock"
gem "pundit"
gem "request_store"

gem "resque", "= 1.26.0" # https://github.com/resque/resque/issues/1552
gem "resque-web", require: "resque_web"
gem "resque-retry"

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
  gem "pry-byebug"
end
