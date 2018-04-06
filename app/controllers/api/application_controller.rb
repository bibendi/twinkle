module Api
  class ApplicationController < ::ActionController::API
    include ::AbstractController::Rendering
    include ::ActionView::Rendering
    include ::ActionController::MimeResponds
    include ::ActionController::ImplicitRender

    include ::Authorizable
    include ::Responsable

    before_action { request.format = :json }
  end
end
