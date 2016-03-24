class AuthenticateUser < ApplicationInteractor
  params :token

  validates :token, presence: true

  def perform
    if user = User.where(token: token).first
      context.user = user
    else
      context.fail!(message: t("errors.messages.token_not_found"))
    end
  end
end
