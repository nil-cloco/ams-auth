module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:not_found, 404, e.to_s)
        end

        rescue_from Pundit::NotAuthorizedError do |e|
          respond(:forbidden, 403, e.to_s)
        end

        rescue_from StandardError do |e|
            puts e.to_json
          respond(:standard_error, 500, e.to_s)
        end
        
      end
    end

    private

    def respond(error, status, message)
      json = { error: error, status: status, message: message }.to_json
      render json: json, status: status
    end
  end
end
