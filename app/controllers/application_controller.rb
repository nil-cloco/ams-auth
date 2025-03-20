class ApplicationController < ActionController::API
    include Pagy::Backend
    
    require 'pagy/extras/headers'
    require 'pagy/extras/limit'
    
    after_action { pagy_headers_merge(@pagy) if @pagy }
    
    include Pundit::Authorization
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    include Error::ErrorHandler
    
    private
    def user_not_authorized
        render json: { message: 'You are not authorized to perform this action' }, status: :unauthorized
    end
end
