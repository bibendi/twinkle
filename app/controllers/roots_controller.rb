class RootsController < ApplicationController
  skip_before_action :authenticate_user

  def show
    skip_authorization
  end
end
