# frozen_string_literal: true
module Clients
  class TeamsController < ApplicationController
    def index
      authorize client, :show_members?
      @client_teams = client.client_teams.includes(:team)
    end

    def new
      authorize client, :create_member?
      @client_team = client.client_teams.build(role: ClientRole::MEMBER)
    end

    def create
      authorize client, :create_member?

      @client_team = client.client_teams.build(params_for_create)

      if @client_team.save
        redirect_to client_path(client), notice: "Membership was successfully created."
      else
        flash.now[:error] = "Error"
        render :new
      end
    end

    def edit
      authorize client_team
    end

    def update
      authorize client_team

      if client_team.update(params_for_update)
        redirect_to client_path(client), notice: "Membership was successfully updated."
      else
        flash.now[:error] = "Error"
        render :edit
      end
    end

    def destroy
      authorize client_team

      client_team.destroy
      redirect_to client_path(client), notice: "Membership was successfully destroyed."
    end

    private

    def client
      @client ||= Client.find(params.require(:client_id))
    end

    def team
      @user ||= Team.find_by!(name: params.require(:name))
    end

    def client_team
      @client_team ||= client.client_teams.find_by!(team_id: team.id)
    end

    def params_for_create
      params.require(:client_team).permit(:team_name, :role_name)
    end

    def params_for_update
      params.require(:client_team).permit(:role_name)
    end
  end
end
