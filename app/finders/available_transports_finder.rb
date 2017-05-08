# frozen_string_literal: true
class AvailableTransportsFinder
  include Findit::Collections

  delegate :client, to: :@channel

  def initialize(channel)
    @channel = channel
  end

  private

  def find
    client.
      transports.
      where.not("exists (select 1 from channel_transports where channel_id = ? and transport_id = transports.id)",
                @channel.id)
  end
end
