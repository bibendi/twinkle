class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    token_validation_context = ValidateToken.call(token: params.require(:token))

    if token_validation_context.success?
      Resque.enqueue(SendMessageJob, params.require(:channel), params.require(:message))
      render json: {status: "ok"}
    else
      render json: {errors: token_validation_context.errors}, status: 400
    end
  end
end
