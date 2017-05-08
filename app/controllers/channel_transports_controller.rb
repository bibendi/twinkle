class ChannelTransportsController < ApplicationController
  def new
    authorize channel, :create_transport?
    @channel_transport = channel.channel_transports.build
  end

  def create
    authorize channel, :create_transport?
    @channel_transport = channel.channel_transports.build(channel_transport_params)

    if @channel_transport.save
      redirect_to client_channel_path(client, channel), notice: 'Transport was successfully add to channel.'
    else
      render :new
    end
  end

  def destroy
    @channel_transport = channel.channel_transports.find_by!(transport_id: params.require(:id))
    authorize @channel_transport

    @channel_transport.destroy
    redirect_to client_channel_path(client, channel), notice: 'Transport was successfully removed from channel.'
  end

  private

  def client
    @client ||= Client.find(params.require(:client_id))
  end

  def channel
    @channel ||= client.channels.find(params.require(:channel_id))
  end

  def channel_transport_params
    params.require(:channel_transport).permit(:transport_id)
  end
end
