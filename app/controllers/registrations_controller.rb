class RegistrationsController < Devise::RegistrationsController
  skip_filter :authenticate_user_from_token!, only: [:create]
  respond_to :json
end
