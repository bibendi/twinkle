class ChannelsController < ApplicationController
  def index
    authorize client, :show_channels?
    @channels = client.channels.order("name asc")
  end

  def show
    @channel = client.channels.find(params.require(:id))
    authorize @channel
  end

  def new
    authorize client, :create_channel?
    @channel = client.channels.build
  end

  def edit
    @channel = client.channels.find(params.require(:id))
    authorize @channel
  end

  def create
    authorize client, :create_channel?
    @channel = client.channels.build(channel_params)

    if @channel.save
      redirect_to client_channels_path(client), notice: 'Channel was successfully created.'
    else
      render :new
    end
  end

  def update
    @channel = client.channels.find(params.require(:id))
    authorize @channel

    if @channel.update(channel_params)
      redirect_to client_channels_path(client), notice: 'Channel was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @channel = client.channels.find(params.require(:id))
    authorize @channel

    @channel.destroy
    redirect_to client_channels_path(client), notice: 'Channel was successfully destroyed.'
  end

  private

  def client
    @client ||= Client.find(params.require(:client_id))
  end

  def channel_params
    params.require(:channel).permit(:name, :active)
  end
end
