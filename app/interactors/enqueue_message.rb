class EnqueueMessage < ApplicationInteractor
  delegate :user, to: :context
  delegate :channel_name, to: :context
  delegate :message, to: :context

  validates :user, presence: true
  validates :channel_name, presence: true
  validates :message, presence: true

  def call
    validate!

    Resque.enqueue(SendMessageJob, user.id, channel_name, message)
  end
end
