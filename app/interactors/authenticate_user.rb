class AuthenticateUser < ApplicationInteractor
  delegate :token, to: :context

  validates :token, presence: true

  def call
    validate!

    if user = User.where(token: token).first
      context.user = user
    else
      context.fail!(message: t("errors.messages.token_not_found"))
    end
  end
end
