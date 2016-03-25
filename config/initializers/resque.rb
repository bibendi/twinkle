unless Rails.env.test?
  Redis.current = Redis.new(url: ENV.fetch("REDIS_URL"))
  Resque.redis = Redis.current
end
