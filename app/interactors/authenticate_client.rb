class AuthenticateClient < ApplicationInteractor
  params :token

  validates :token, presence: true

  private

  def perform
    if client = Client.find_by(token: token)
      context.client = client
    else
      context.fail!(message: t("errors.messages.token_not_found"))
    end
  end
end
