ENV["RAILS_ENV"] ||= "test"

require "simplecov"
SimpleCov.start "rails" do
  minimum_coverage 95
end

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "pundit/rspec"
require "mock_redis"
require "support/auth"

redis = MockRedis.new
Redis.current = redis
Resque.redis = redis

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include TwinkleTesting::Auth

  config.before do
    Redis.current.flushdb
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
