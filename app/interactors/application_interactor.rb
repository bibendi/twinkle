class ApplicationInteractor
  include Interactor
  include ActiveModel::Validations

  delegate :t, to: :I18n

  def self.params(*names)
    delegate *names, to: :context
  end

  private

  def call
    validate!
    perform
  end

  def validate!
    return if valid?
    context.fail!(message: errors.to_a.join("; "))
  end
end
