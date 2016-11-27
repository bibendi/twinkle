class ClientsController < ApplicationController
  def index
    @clients = Client.order("name asc")
  end

  def show
    @client = Client.find(params.require(:id))
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to clients_path, notice: "Client was successfully created."
    else
      flash.now[:error] = "Error"
      render :new
    end
  end

  def edit
    @client = Client.find(params.require(:id))
  end

  def update
    @client = Client.find(params.require(:id))

    if @client.update(client_params)
      redirect_to clients_path, notice: "Client was successfully updated."
    else
      flash.now[:error] = "Error"
      render :edit
    end
  end

  def destroy
    Client.find(params.require(:id)).destroy
    redirect_to clients_path, notice: "Client was successfully destroyed."
  end

  private

  def client_params
    params.require(:client).permit(:name, :active)
  end
end
