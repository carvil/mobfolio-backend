class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_filter :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    authenticate_or_request_with_http_token do |token, options|
      user = User.find_by(authentication_token: token)

      if user && Devise.secure_compare(user.authentication_token, token)
        sign_in user, store: false
      end
    end
  end
end
