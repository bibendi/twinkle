module Transports
  class TelegramsController < ApplicationController
    def index
      authorize client, :show_transports?
      @telegrams = client.transports.telegrams.order("id asc").all
    end

    def show
      @telegram = client.transports.telegrams.find(params.require(:id))
      authorize @telegram
    end

    def new
      authorize client, :create_transport?
      @telegram = client.transports.build(type: "Transports::Telegram")
    end

    def edit
      @telegram = client.transports.telegrams.find(params.require(:id))
      authorize @telegram
    end

    def create
      authorize client, :create_transport?
      @telegram = client.transports.build(chat_params.merge(type: "Transports::Telegram"))

      if @telegram.save
        redirect_to client_transports_telegrams_path(client), notice: 'Telegram chat was successfully created.'
      else
        render :new
      end
    end

    def update
      @telegram = client.transports.telegrams.find(params.require(:id))
      authorize @telegram

      if @telegram.update(chat_params)
        redirect_to client_transports_telegrams_path(client), notice: 'Telegram chat was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @telegram = @client.transports.telegrams.find(params.require(:id))
      authorize @telegram

      @telegram.destroy
      redirect_to client_transports_telegrams_path(client), notice: 'Telegram chat was successfully destroyed.'
    end

    private

    def client
      @client ||= Client.find(params.require(:client_id))
    end

    def chat_params
      params.require(:telegram).permit(:chat_name, :chat_id)
    end
  end
end
