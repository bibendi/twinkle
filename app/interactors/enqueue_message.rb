class EnqueueMessage < ApplicationInteractor
  params :client, :channel_name, :message, :json_vars

  validates :client, :channel_name, :message, presence: true

  def perform
    Resque.enqueue(SendMessageJob, client.id, channel_name, message, json_vars)
  end
end
