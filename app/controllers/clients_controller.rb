class ClientsController < ApplicationController
  def index
    @clients = Client.order("name asc")
    authorize current_user, :show_clients?
  end

  def show
    @client = Client.find(params.require(:id))
    authorize @client
  end

  def new
    @client = Client.new
    authorize @client
  end

  def create
    @client = Client.new(client_params)
    authorize @client

    if @client.save
      redirect_to clients_path, notice: "Client was successfully created."
    else
      flash.now[:error] = "Error"
      render :new
    end
  end

  def edit
    @client = Client.find(params.require(:id))
    authorize @client
  end

  def update
    @client = Client.find(params.require(:id))
    authorize @client

    if @client.update(client_params)
      redirect_to clients_path, notice: "Client was successfully updated."
    else
      flash.now[:error] = "Error"
      render :edit
    end
  end

  def destroy
    @client = Client.find(params.require(:id))
    authorize @client
    
    @client.destroy
    redirect_to clients_path, notice: "Client was successfully destroyed."
  end

  private

  def client_params
    params.require(:client).permit(:name, :active)
  end
end
