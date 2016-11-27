class ChannelsController < ApplicationController
  def index
    find_client

    @channels = @client.channels.order("name asc")
  end

  def show
    find_client

    @channel = @client.channels.find(params.require(:id))
  end

  def new
    find_client

    @channel = @client.channels.build
  end

  def edit
    find_client

    @channel = @client.channels.find(params.require(:id))
  end

  def create
    find_client

    @channel = @client.channels.build(channel_params)

    if @channel.save
      redirect_to client_channels_path(@client), notice: 'Channel was successfully created.'
    else
      render :new
    end
  end

  def update
    find_client

    @channel = @client.channels.find(params.require(:id))

    if @channel.update(channel_params)
      redirect_to client_channels_path(@client), notice: 'Channel was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    find_client

    @client.channels.find(params.require(:id)).destroy
    redirect_to client_channels_path(@client), notice: 'Channel was successfully destroyed.'
  end

  private

  def find_client
    @client = Client.find(params.require(:client_id))
  end

  def channel_params
    params.require(:channel).permit(:name, :active)
  end
end
