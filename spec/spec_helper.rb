ENV["RAILS_ENV"] ||= "test"

require "simplecov"
SimpleCov.start "rails" do
  minimum_coverage 95
end

require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"

require "mock_redis"
redis = MockRedis.new
Redis.current = redis
Resque.redis = redis

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before do
    Redis.current.flushdb
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
