class ApplicationInteractor
  include Interactor
  include ActiveModel::Validations

  delegate :t, to: :I18n

  private

  def validate!
    return if valid?
    context.fail!(message: errors.to_a.join("; "))
  end
end
