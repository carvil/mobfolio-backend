class AppsController < ApplicationController
  respond_to :json

  def index
    render json: { apps: current_user.apps }
  end

  def update
    app = current_user.apps.find(params[:id])
    app.update_attributes(name: params[:name])
    render json: { app: app }
  end

  def show
    render json: { app: current_user.apps.find(params[:id]) }
  end

  def create
    app = App.new(app_params)
    app.user = current_user
    app.save
    render json: { app: app.as_json }, status: 201
  end

  def destroy
    app = current_user.apps.find(params[:id])
    app.destroy
    head 200
  end

  private

  def app_params
    params.require(:app).permit(:name, :user_id)
  end
end
