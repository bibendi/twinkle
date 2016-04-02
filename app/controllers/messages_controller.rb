class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    auth_context = AuthenticateUser.call(token: params[:token])

    if auth_context.success?
      enqueue_context = EnqueueMessage.call(user: auth_context.user,
                                            channel_name: params[:channel],
                                            message: params[:message],
                                            json_vars: params[params[:json_vars]])
      if enqueue_context.success?
        head 200
      else
        render json: {message: enqueue_context.message}, status: 400
      end
    else
      render json: {message: auth_context.message}, status: 403
    end
  end
end
