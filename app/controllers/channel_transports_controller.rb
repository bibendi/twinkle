class ChannelTransportsController < ApplicationController
  def new
    find_channel

    @channel_transport = @channel.channel_transports.build
  end

  def create
    find_channel

    @channel_transport = @channel.channel_transports.build(channel_transport_params)

    if @channel_transport.save
      redirect_to client_channel_path(@client, @channel), notice: 'Transport was successfully add to channel.'
    else
      render :new
    end
  end

  def destroy
    find_channel

    @channel.channel_transports.find_by!(transport_id: params.require(:id)).destroy
    redirect_to client_channel_path(@client, @channel), notice: 'Transport was successfully removed from channel.'
  end

  private

  def find_client
    @client = Client.find(params.require(:client_id))
  end

  def find_channel
    find_client
    @channel = @client.channels.find(params.require(:channel_id))
  end

  def channel_transport_params
    params.require(:channel_transport).permit(:transport_id)
  end
end
