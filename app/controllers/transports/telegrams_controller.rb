module Transports
  class TelegramsController < ApplicationController
    def index
      find_client

      @telegrams = @client.transports.telegrams.order("id asc").all
    end

    def show
      find_client

      @telegram = @client.transports.telegrams.find(params.require(:id))
    end

    def new
      find_client

      @telegram = @client.transports.build(type: "Transports::Telegram")
    end

    def edit
      find_client

      @telegram = @client.transports.telegrams.find(params.require(:id))
    end

    def create
      find_client

      @telegram = @client.transports.build(chat_params.merge(type: "Transports::Telegram"))

      if @telegram.save
        redirect_to client_transports_telegrams_path(@client), notice: 'Telegram chat was successfully created.'
      else
        render :new
      end
    end

    def update
      find_client

      @telegram = @client.transports.telegrams.find(params.require(:id))

      if @telegram.update(chat_params)
        redirect_to client_transports_telegrams_path(@client), notice: 'Telegram chat was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      find_client

      @client.transports.telegrams.find(params.require(:id)).destroy

      redirect_to client_transports_telegrams_path(@client), notice: 'Telegram chat was successfully destroyed.'
    end

    private

    def find_client
      @client = Client.find(params.require(:client_id))
    end

    def chat_params
      params.require(:telegram).permit(:chat_name, :chat_id)
    end
  end
end
