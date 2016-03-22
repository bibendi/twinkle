class ValidateToken
  include Interactor
  include ActiveModel::Validations

  delegate :token, to: :context

  validates :token, presence: true
  validate :secret_token_equality

  def call
    context.fail!(errors: errors) unless valid?
  end

  private

  def secret_token_equality
    return if token == ENV.fetch("SECRET_TOKEN")
    errors.add(:token, "No valid token")
  end
end
