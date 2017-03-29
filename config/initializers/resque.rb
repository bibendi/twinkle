if ENV["REDIS_URL"] && !Rails.env.test?
  Redis.current = Redis.new(url: ENV.fetch("REDIS_URL"))
  Resque.redis = Redis.current
end

require "resque/failure"
require "resque/failure/redis"
Resque::Failure::MultipleWithRetrySuppression.classes = [Resque::Failure::Redis]
Resque::Failure.backend = Resque::Failure::MultipleWithRetrySuppression

# FIXME: Logging control is broken in resque-1.26.0
#        https://github.com/resque/resque/blob/v1.26.0/lib/resque/worker.rb#L130
ENV["VERBOSE"] = '1'
# Resque.logger.level = Logger::INFO
# Resque.logger.formatter = Resque::VeryVerboseFormatter.new
require "resque/log_formatters/verbose_formatter"
module Resque
  class VerboseFormatter
    def call(serverity, datetime, progname, msg)
      time = Time.now.strftime('%H:%M:%S %Y-%m-%d')
      "** [#{time}] #$$: #{msg}\n"
    end
  end
end
