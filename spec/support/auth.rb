module TwinkleTesting
  module Auth
    def authenticate(user)
      controller.session[:remember_token] = user.remember_token
    end

    def authorize(role_name)
      user.role_id = ::Role.find_by_name(role_name.to_s).id
      user.save!
    end
  end
end
