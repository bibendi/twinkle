json.message(exception.try(:message))

if exception.backtrace.present? && !Rails.env.production?
  json.backtrace(exception.backtrace)
end
