class ApplicationController < ActionController::API
  include Pagy::Backend

  require "pagy/extras/headers"
  require "pagy/extras/limit"

  after_action { pagy_headers_merge(@pagy) if @pagy }

  include Pundit::Authorization
  include Error::ErrorHandler
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def page_not_found
    respond_to do |format|
      format.html { render template: "errors/not_found_error", layout: "layouts/application", status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  private

  def user_not_authorized
    render json: { error: "You are not authorized to perform this action" }, status: 403
  end
end
