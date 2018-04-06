# frozen_string_literal: true
module Clients
  class UsersController < ApplicationController
    def index
      authorize client, :show_members?
      @client_users = client.client_users.includes(:user)
    end

    def new
      authorize client, :create_member?
      @client_user = client.client_users.build(role: ClientRole::MEMBER)
    end

    def create
      authorize client, :create_member?

      @client_user = client.client_users.build(params_for_create)

      if @client_user.save
        redirect_to client_path(client), notice: "Membership was successfully created."
      else
        flash.now[:error] = "Error"
        render :new
      end
    end

    def edit
      authorize client_user
    end

    def update
      authorize client_user

      if client_user.update(params_for_update)
        redirect_to client_path(client), notice: "Membership was successfully updated."
      else
        flash.now[:error] = "Error"
        render :edit
      end
    end

    def destroy
      authorize client_user

      client_user.destroy
      redirect_to client_path(client), notice: "Membership was successfully destroyed."
    end

    private

    def client
      @client ||= Client.find(params.require(:client_id))
    end

    def user
      @user ||= User.find_by!(username: params.require(:username))
    end

    def client_user
      @client_user ||= client.client_users.find_by!(user_id: user.id)
    end

    def params_for_create
      params.require(:client_user).permit(:username, :role_name)
    end

    def params_for_update
      params.require(:client_user).permit(:role_name)
    end
  end
end
