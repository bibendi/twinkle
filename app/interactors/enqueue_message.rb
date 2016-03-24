class EnqueueMessage < ApplicationInteractor
  params :user, :channel_name, :message

  validates :user, :channel_name, :message, presence: true

  def perform
    Resque.enqueue(SendMessageJob, user.id, channel_name, message)
  end
end
