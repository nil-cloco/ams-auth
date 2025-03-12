class ApplicationController < ActionController::API
    include Pagy::Backend
    require 'pagy/extras/headers'
    require 'pagy/extras/limit'
    after_action { pagy_headers_merge(@pagy) if @pagy }
end
