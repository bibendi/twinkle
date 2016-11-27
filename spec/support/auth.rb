module TwinkleTesting
  module Auth
    def authenticate(user)
      controller.session[:remember_token] = user.remember_token
    end
  end
end
