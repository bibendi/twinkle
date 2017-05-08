module Api
  module V1
    class ClientsController < ::Api::ApplicationController
      before_action { authorize current_owner, :manage? }

      def index
        authorize current_user, :show_clients?
        @clients = UserClientsFinder.new(current_user)
      end

      def show
        @client = ::Client.find(params.require(:id))
        authorize @client
      end

      def create
        authorize current_user, :create_client?
        @client = ::Client.new(client_params)
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
