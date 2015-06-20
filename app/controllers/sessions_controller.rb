class SessionsController < Devise::SessionsController
  skip_filter :authenticate_user_from_token!, only: [:create]
  respond_to :json

  def create
    respond_to do |format|
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        data = {
          token: self.resource.authentication_token,
          email: self.resource.email
        }
        render json: data, status: 201
      end
    end
  end
end
