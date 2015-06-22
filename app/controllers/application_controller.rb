class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_filter :authenticate_user_from_token!

  rescue_from ActionController::ParameterMissing do |exception|
    json_error(exception.message, :bad_request)
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    json_error 'Record not found', :not_found
  end

  private

  def json_error(message, status)
    body = { message: message }
    render json: body, status: status
  end

  def authenticate_user_from_token!
    authenticate_or_request_with_http_token do |token, options|
      user = User.find_by(authentication_token: token)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end
end
