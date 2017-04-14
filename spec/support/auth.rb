module TwinkleTesting
  module Auth
    def authenticate(user, payload = {})
      token = ::Knock::AuthToken.new(payload: payload.merge(sub: user.id)).token
      request.headers['Authorization'] = "Bearer #{token}"
    end
  end
end
