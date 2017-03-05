if ENV["REDIS_URL"] && !Rails.env.test?
  Redis.current = Redis.new(url: ENV.fetch("REDIS_URL"))
  Resque.redis = Redis.current

  require "resque/failure"
  require "resque/failure/redis"

  Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis]
  Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression
end
