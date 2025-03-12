class ApplicationController < ActionController::API
    include Pagy::Backend
    
    require 'pagy/extras/headers'
    require 'pagy/extras/limit'
    
    after_action { pagy_headers_merge(@pagy) if @pagy }
    
    
    include Pundit::Authorization
    # Handle unauthorized errors
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
        render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
    end
end
