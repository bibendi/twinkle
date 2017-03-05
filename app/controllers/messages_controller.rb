class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token,
                     :authenticate

  def create
    find_client
    return forbidden unless @client

    json_vars = if (vars_key = params[:json_vars].presence)
                  params[vars_key]
                else
                  params.except(:controller, :action).to_json
                end

    enqueue_context = EnqueueMessage.call(client: @client,
                                          channel_name: params.require(:channel),
                                          message: params.require(:message),
                                          json_vars: json_vars)
    if enqueue_context.success?
      head 200
    else
      render json: {message: enqueue_context.message}, status: 400
    end
  end

  private

  def find_client
    auth_context = AuthenticateClient.call(token: params.require(:token))
    @client = auth_context.client if auth_context.success?
  end
end
