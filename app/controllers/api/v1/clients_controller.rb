module Api
  module V1
    class ClientsController < ::Api::ApplicationController
      before_action { authorize current_owner, :manage? }

      def index
        @clients = ::Client.order("name asc")
        authorize ::User, :show_clients?
      end

      def show
        @client = ::Client.find(params.require(:id))
        authorize @client
      end

      def create
        @client = ::Client.new(client_params)
        authorize @client
        render(status: 422) unless @client.save
      end

      def update
        @client = ::Client.find(params.require(:id))
        authorize @client
        render(status: 422) unless @client.update(client_params)
      end

      def destroy
        @client = ::Client.find(params.require(:id))
        authorize @client
        render(status: 422) unless @client.destroy
      end

      private

      def client_params
        params.require(:client).permit(:name, :active)
      end
    end
  end
end
