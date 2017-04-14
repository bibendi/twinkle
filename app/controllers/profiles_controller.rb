class ProfilesController < ApplicationController
  def show
    skip_authorization
    @user = current_user
  end
end
