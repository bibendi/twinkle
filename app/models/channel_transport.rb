class ChannelTransport < ActiveRecord::Base
  belongs_to :channel, required: true
  belongs_to :transport, required: true

  before_validation :check_user, if: -> { channel_id_changed? || transport_id_changed? }

  private

  def check_user
    return if channel.try(:client_id) == transport.try(:client_id)
    errors.add(:transport, :invalid)
  end
end
